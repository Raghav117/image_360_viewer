import 'dart:async';
import 'dart:io';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:sensors_plus/sensors_plus.dart';

import '../models/image_360_config.dart';
import '../models/image_360_state.dart';

/// ViewModel for managing Image360Viewer business logic
class Image360ViewModel extends ChangeNotifier {
  final Image360Config _config;

  Image360State _state = const Image360State();
  Image360State get state => _state;

  // Animation and timing
  Timer? _autoRotateTimer;
  Timer? _gyroTimer;
  StreamSubscription<GyroscopeEvent>? _gyroSubscription;

  // Animation controllers
  double _rotationVelocity = 0.0;
  DateTime _lastPanUpdate = DateTime.now();

  // Scale gesture tracking
  Offset? _lastFocalPoint;
  double _lastScale = 1.0;

  // Gyroscope data
  StreamSubscription<GyroscopeEvent>? _gyroscopeSubscription;

  // Preloaded images cache
  final Map<int, ImageProvider> _imageCache = {};
  final Map<int, bool> _loadingStates = {};

  Image360ViewModel(this._config) {
    _initializeState();
    _preloadImages();
    if (_config.autoRotate) {
      startAutoRotate();
    }
    if (_config.gyroEnabled) {
      _initializeGyroscope();
    }
  }

  Image360Config get config => _config;

  void _initializeState() {
    _state = Image360State(
      currentFrame: _config.initialFrame,
      isLoading: true,
      zoomLevel: 1.0,
      panOffset: Offset.zero,
      isAutoRotating: _config.autoRotate,
      rotationDirection: 1,
    );
  }

  /// Preload images based on source type
  Future<void> _preloadImages() async {
    try {
      switch (_config.sourceType) {
        case ImageSourceType.asset:
          await _preloadAssetImages();
          break;
        case ImageSourceType.file:
          await _preloadFileImages();
          break;
        case ImageSourceType.network:
          await _preloadNetworkImages();
          break;
      }

      _state = _state.copyWith(isLoading: false);
      notifyListeners();
    } catch (e) {
      _state = _state.copyWith(
        isLoading: false,
        hasError: true,
        errorMessage: 'Failed to load images: $e',
      );
      notifyListeners();
    }
  }

  Future<void> _preloadAssetImages() async {
    if (_config.imageAssetList == null || _config.imageAssetList!.isEmpty)
      return;

    for (int i = 0; i < _config.imageAssetList!.length; i++) {
      final imagePath = _config.imageAssetList![i];
      _imageCache[i] = AssetImage(imagePath);
      _loadingStates[i] = true;
    }
  }

  Future<void> _preloadFileImages() async {
    if (_config.imageFilePaths == null) return;

    for (int i = 0; i < _config.imageFilePaths!.length; i++) {
      final file = File(_config.imageFilePaths![i]);
      if (await file.exists()) {
        _imageCache[i] = FileImage(file);
        _loadingStates[i] = true;
      }
    }
  }

  Future<void> _preloadNetworkImages() async {
    if (_config.imageUrls == null) return;

    for (int i = 0; i < _config.imageUrls!.length; i++) {
      _imageCache[i] = CachedNetworkImageProvider(_config.imageUrls![i]);
      _loadingStates[i] = true;
    }
  }

  /// Get the current image provider
  ImageProvider? getCurrentImageProvider() {
    return _imageCache[_state.currentFrame];
  }

  /// Get total frame count based on source type
  int get totalFrames {
    switch (_config.sourceType) {
      case ImageSourceType.asset:
        return _config.imageAssetList?.length ?? 0;
      case ImageSourceType.file:
        return _config.imageFilePaths?.length ?? 0;
      case ImageSourceType.network:
        return _config.imageUrls?.length ?? 0;
    }
  }

  /// Handle scale gesture start
  void onScaleStart(ScaleStartDetails details) {
    _lastFocalPoint = details.focalPoint;
    _lastScale = 1.0;
    _lastPanUpdate = DateTime.now();

    // Stop auto-rotation when user starts interacting
    if (_state.isAutoRotating) {
      stopAutoRotate();
    }
  }

  /// Handle scale gesture updates (both pan and zoom)
  void onScaleUpdate(ScaleUpdateDetails details) {
    if (totalFrames == 0) return;

    final now = DateTime.now();
    final deltaTime = now.difference(_lastPanUpdate).inMilliseconds;
    _lastPanUpdate = now;

    // Handle zoom if enabled
    if (_config.zoomEnabled && details.scale != _lastScale) {
      final newZoom =
          (_state.zoomLevel * (details.scale / _lastScale)).clamp(1.0, 3.0);
      _state = _state.copyWith(zoomLevel: newZoom);
      _lastScale = details.scale;
    }

    // Handle rotation based on horizontal movement
    if (_lastFocalPoint != null) {
      final deltaX = details.focalPoint.dx - _lastFocalPoint!.dx;

      // Only rotate if not zooming (scale close to 1.0)
      if ((details.scale - 1.0).abs() < 0.1) {
        const sensitivity = 2.0;
        final deltaRotation = deltaX * sensitivity;

        // Update velocity for momentum
        if (deltaTime > 0) {
          _rotationVelocity = deltaRotation / deltaTime;
        }

        // Update frame based on rotation
        final frameChange = (deltaRotation / 10).round();
        if (frameChange != 0) {
          _updateFrame(_state.currentFrame + frameChange);
        }
      }

      // Handle pan offset when zoomed
      if (_state.zoomLevel > 1.0) {
        final deltaOffset = details.focalPoint - _lastFocalPoint!;
        final newOffset = _state.panOffset + deltaOffset;
        _state = _state.copyWith(panOffset: newOffset);
      }
    }

    _lastFocalPoint = details.focalPoint;
    notifyListeners();
  }

  /// Handle scale gesture end
  void onScaleEnd(ScaleEndDetails details) {
    _lastFocalPoint = null;
    _lastScale = 1.0;

    // Apply momentum rotation if there was significant velocity
    if (_rotationVelocity.abs() > 0.1) {
      _startMomentumRotation();
    }

    // Restart auto-rotate if it was enabled and we're not zoomed
    if (_config.autoRotate && _state.zoomLevel <= 1.0) {
      Future.delayed(const Duration(seconds: 2), () {
        if (!_state.isAutoRotating && _state.zoomLevel <= 1.0) {
          startAutoRotate();
        }
      });
    }
  }

  /// Apply momentum rotation after gesture ends
  void _startMomentumRotation() {
    Timer.periodic(const Duration(milliseconds: 16), (timer) {
      if (_rotationVelocity.abs() < 0.01) {
        timer.cancel();
        return;
      }

      final frameChange = (_rotationVelocity * 0.5).round();
      if (frameChange != 0) {
        _updateFrame(_state.currentFrame + frameChange);
      }

      _rotationVelocity *= 0.95; // Friction
    });
  }

  /// Initialize gyroscope if enabled
  void _initializeGyroscope() {
    _gyroscopeSubscription =
        gyroscopeEventStream().listen((GyroscopeEvent event) {
      if (!_config.gyroEnabled || totalFrames == 0) return;

      // Use Y-axis rotation for horizontal spinning with configurable sensitivity
      final rotationSpeed = event.y *
          10 *
          _config.gyroSensitivity; // Apply sensitivity multiplier
      final frameChange = rotationSpeed.round();

      if (frameChange.abs() > 0) {
        _updateFrame(_state.currentFrame + frameChange);
      }
    });
  }

  /// Update current frame with bounds checking
  void _updateFrame(int newFrame) {
    if (totalFrames == 0) return;

    int frame = newFrame;

    if (_config.reverseOnEnd) {
      // Handle reverse/mirror playback
      if (frame >= totalFrames) {
        _state = _state.copyWith(rotationDirection: -1);
        frame = totalFrames - 1;
      } else if (frame < 0) {
        _state = _state.copyWith(rotationDirection: 1);
        frame = 0;
      }
    } else {
      // Handle normal looping
      frame = frame % totalFrames;
      if (frame < 0) frame += totalFrames;
    }

    if (frame != _state.currentFrame) {
      _state = _state.copyWith(currentFrame: frame);
      notifyListeners();
    }
  }

  /// Start auto-rotation
  void startAutoRotate() {
    if (_autoRotateTimer?.isActive == true) return;

    _autoRotateTimer = Timer.periodic(
      Duration(milliseconds: _config.autoRotateSpeed),
      (timer) {
        if (!_state.isAutoRotating) {
          timer.cancel();
          return;
        }

        final nextFrame = _state.currentFrame + _state.rotationDirection;
        _updateFrame(nextFrame);
      },
    );

    _state = _state.copyWith(isAutoRotating: true);
    notifyListeners();
  }

  /// Stop auto-rotation
  void stopAutoRotate() {
    _autoRotateTimer?.cancel();
    _state = _state.copyWith(isAutoRotating: false);
    notifyListeners();
  }

  /// Toggle auto-rotation
  void toggleAutoRotate() {
    if (_state.isAutoRotating) {
      stopAutoRotate();
    } else {
      startAutoRotate();
    }
  }

  /// Reset zoom and pan
  void resetZoomAndPan() {
    _state = _state.copyWith(
      zoomLevel: 1.0,
      panOffset: Offset.zero,
    );
    notifyListeners();
  }

  /// Get shadow intensity for current frame (for lighting effects)
  double getShadowIntensity() {
    if (totalFrames == 0) return 0.0;

    final normalizedFrame = _state.currentFrame / totalFrames;
    final angle = normalizedFrame * 2 * math.pi; // Full rotation

    // Simple sine wave for shadow intensity
    return (1 + 0.5 * (1 + math.sin(angle * 2))) * 0.3;
  }

  /// Load specific frame image
  Future<void> loadFrameImage(int frameIndex) async {
    if (_loadingStates[frameIndex] == true) return;

    _loadingStates[frameIndex] = true;

    try {
      switch (_config.sourceType) {
        case ImageSourceType.asset:
          if (_config.imageAssetList != null &&
              frameIndex < _config.imageAssetList!.length) {
            // Asset loading is handled in preload
            final imagePath = _config.imageAssetList![frameIndex];
            _imageCache[frameIndex] = AssetImage(imagePath);
          }
          break;
        case ImageSourceType.file:
          if (_config.imageFilePaths != null &&
              frameIndex < _config.imageFilePaths!.length) {
            final file = File(_config.imageFilePaths![frameIndex]);
            if (await file.exists()) {
              _imageCache[frameIndex] = FileImage(file);
            }
          }
          break;
        case ImageSourceType.network:
          if (_config.imageUrls != null &&
              frameIndex < _config.imageUrls!.length) {
            _imageCache[frameIndex] =
                CachedNetworkImageProvider(_config.imageUrls![frameIndex]);
          }
          break;
      }
    } catch (e) {
      // Handle loading error for specific frame
      debugPrint('Failed to load frame $frameIndex: $e');
    }

    _loadingStates[frameIndex] = false;
  }

  @override
  void dispose() {
    _autoRotateTimer?.cancel();
    _gyroTimer?.cancel();
    _gyroSubscription?.cancel();
    _gyroscopeSubscription?.cancel();
    super.dispose();
  }
}
