import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../models/image_360_config.dart';
import '../viewmodels/image_360_viewmodel.dart';

/// A powerful Flutter widget for interactive 360° object rotation
class Image360Viewer extends StatefulWidget {
  final Image360Config config;
  final Widget? loadingWidget;
  final Widget? errorWidget;
  final Function(int frameIndex)? onFrameChanged;
  final double Function(int frameIndex)? shadowIntensityByFrame;

  const Image360Viewer._({
    super.key,
    required this.config,
    this.loadingWidget,
    this.errorWidget,
    this.onFrameChanged,
    this.shadowIntensityByFrame,
  });

  /// Create Image360Viewer from asset images
  factory Image360Viewer.asset({
    Key? key,
    required List<String> imageAssetList,
    bool autoRotate = false,
    bool zoomEnabled = true,
    bool gyroEnabled = false,
    double gyroSensitivity = 1.0,
    bool reverseOnEnd = false,
    int autoRotateSpeed = 100,
    int initialFrame = 0,
    double? width,
    double? height,
    Color backgroundColor = Colors.transparent,
    Widget? loadingWidget,
    Widget? errorWidget,
    Function(int frameIndex)? onFrameChanged,
    double Function(int frameIndex)? shadowIntensityByFrame,
  }) {
    return Image360Viewer._(
      key: key,
      config: Image360Config.asset(
        imageAssetList: imageAssetList,
        autoRotate: autoRotate,
        zoomEnabled: zoomEnabled,
        gyroEnabled: gyroEnabled,
        gyroSensitivity: gyroSensitivity,
        reverseOnEnd: reverseOnEnd,
        autoRotateSpeed: autoRotateSpeed,
        initialFrame: initialFrame,
        width: width,
        height: height,
        backgroundColor: backgroundColor,
      ),
      loadingWidget: loadingWidget,
      errorWidget: errorWidget,
      onFrameChanged: onFrameChanged,
      shadowIntensityByFrame: shadowIntensityByFrame,
    );
  }

  /// Create Image360Viewer from file paths
  factory Image360Viewer.file({
    Key? key,
    required List<String> imageFilePaths,
    bool autoRotate = false,
    bool zoomEnabled = true,
    bool gyroEnabled = false,
    double gyroSensitivity = 1.0,
    bool reverseOnEnd = false,
    int autoRotateSpeed = 100,
    int initialFrame = 0,
    double? width,
    double? height,
    Color backgroundColor = Colors.transparent,
    Widget? loadingWidget,
    Widget? errorWidget,
    Function(int frameIndex)? onFrameChanged,
    double Function(int frameIndex)? shadowIntensityByFrame,
  }) {
    return Image360Viewer._(
      key: key,
      config: Image360Config.file(
        imageFilePaths: imageFilePaths,
        autoRotate: autoRotate,
        zoomEnabled: zoomEnabled,
        gyroEnabled: gyroEnabled,
        gyroSensitivity: gyroSensitivity,
        reverseOnEnd: reverseOnEnd,
        autoRotateSpeed: autoRotateSpeed,
        initialFrame: initialFrame,
        width: width,
        height: height,
        backgroundColor: backgroundColor,
      ),
      loadingWidget: loadingWidget,
      errorWidget: errorWidget,
      onFrameChanged: onFrameChanged,
      shadowIntensityByFrame: shadowIntensityByFrame,
    );
  }

  /// Create Image360Viewer from network URLs
  factory Image360Viewer.networkList({
    Key? key,
    required List<String> imageUrls,
    bool autoRotate = false,
    bool zoomEnabled = true,
    bool gyroEnabled = false,
    double gyroSensitivity = 1.0,
    bool reverseOnEnd = false,
    int autoRotateSpeed = 100,
    int initialFrame = 0,
    double? width,
    double? height,
    Color backgroundColor = Colors.transparent,
    Widget? loadingWidget,
    Widget? errorWidget,
    Function(int frameIndex)? onFrameChanged,
    double Function(int frameIndex)? shadowIntensityByFrame,
  }) {
    return Image360Viewer._(
      key: key,
      config: Image360Config.network(
        imageUrls: imageUrls,
        autoRotate: autoRotate,
        zoomEnabled: zoomEnabled,
        gyroEnabled: gyroEnabled,
        gyroSensitivity: gyroSensitivity,
        reverseOnEnd: reverseOnEnd,
        autoRotateSpeed: autoRotateSpeed,
        initialFrame: initialFrame,
        width: width,
        height: height,
        backgroundColor: backgroundColor,
      ),
      loadingWidget: loadingWidget,
      errorWidget: errorWidget,
      onFrameChanged: onFrameChanged,
      shadowIntensityByFrame: shadowIntensityByFrame,
    );
  }

  @override
  State<Image360Viewer> createState() => _Image360ViewerState();
}

class _Image360ViewerState extends State<Image360Viewer> {
  late Image360ViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = Image360ViewModel(widget.config);
    _viewModel.addListener(_onViewModelChanged);
  }

  void _onViewModelChanged() {
    if (mounted) {
      setState(() {});
      widget.onFrameChanged?.call(_viewModel.state.currentFrame);
    }
  }

  @override
  void dispose() {
    _viewModel.removeListener(_onViewModelChanged);
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.config.width,
      height: widget.config.height,
      color: widget.config.backgroundColor,
      child: _buildContent(),
    );
  }

  Widget _buildContent() {
    if (_viewModel.state.isLoading) {
      return widget.loadingWidget ??
          const Center(child: CircularProgressIndicator());
    }

    if (_viewModel.state.hasError) {
      return widget.errorWidget ??
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error, size: 48, color: Colors.red),
                const SizedBox(height: 8),
                Text(
                  _viewModel.state.errorMessage ?? 'Failed to load images',
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
    }

    return GestureDetector(
      onScaleStart: _viewModel.onScaleStart,
      onScaleUpdate: _viewModel.onScaleUpdate,
      onScaleEnd: _viewModel.onScaleEnd,
      child: Transform.scale(
        scale: _viewModel.state.zoomLevel,
        child: Transform.translate(
          offset: _viewModel.state.panOffset,
          child: _buildImageWithShadow(),
        ),
      ),
    );
  }

  Widget _buildImageWithShadow() {
    final imageProvider = _viewModel.getCurrentImageProvider();
    if (imageProvider == null) {
      return widget.errorWidget ??
          const Center(child: Icon(Icons.image_not_supported));
    }

    Widget imageWidget;

    if (widget.config.sourceType == ImageSourceType.network) {
      // Use CachedNetworkImage for network images
      final imageUrl = widget.config.imageUrls![_viewModel.state.currentFrame];
      imageWidget = CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.contain,
        placeholder: (context, url) =>
            const Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      );
    } else {
      // Use Image widget for assets and files
      imageWidget = Image(
        image: imageProvider,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return widget.errorWidget ?? const Icon(Icons.error);
        },
      );
    }

    // Apply shadow effect if callback is provided
    final shadowIntensity =
        widget.shadowIntensityByFrame?.call(_viewModel.state.currentFrame) ??
            0.0;

    if (shadowIntensity > 0) {
      return Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: shadowIntensity),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: imageWidget,
      );
    }

    return imageWidget;
  }
}
