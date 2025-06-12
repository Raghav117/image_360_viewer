import 'package:flutter/material.dart';

/// State model for Image360Viewer
class Image360State {
  /// Current frame index being displayed
  final int currentFrame;

  /// Current zoom level
  final double zoomLevel;

  /// Current pan offset for zoomed images
  final Offset panOffset;

  /// Whether auto-rotation is currently active
  final bool isAutoRotating;

  /// Current rotation direction (1 = forward, -1 = backward)
  final int rotationDirection;

  /// Loading state
  final bool isLoading;

  /// Error state
  final bool hasError;

  /// Error message if any
  final String? errorMessage;

  const Image360State({
    this.currentFrame = 0,
    this.zoomLevel = 1.0,
    this.panOffset = Offset.zero,
    this.isAutoRotating = false,
    this.rotationDirection = 1,
    this.isLoading = false,
    this.hasError = false,
    this.errorMessage,
  });

  /// Copy with method for immutable state updates
  Image360State copyWith({
    int? currentFrame,
    double? zoomLevel,
    Offset? panOffset,
    bool? isAutoRotating,
    int? rotationDirection,
    bool? isLoading,
    bool? hasError,
    String? errorMessage,
  }) {
    return Image360State(
      currentFrame: currentFrame ?? this.currentFrame,
      zoomLevel: zoomLevel ?? this.zoomLevel,
      panOffset: panOffset ?? this.panOffset,
      isAutoRotating: isAutoRotating ?? this.isAutoRotating,
      rotationDirection: rotationDirection ?? this.rotationDirection,
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  /// Clear error state
  Image360State clearError() {
    return copyWith(hasError: false, errorMessage: null);
  }

  /// Set loading state
  Image360State setLoading(bool loading) {
    return copyWith(isLoading: loading);
  }

  /// Set error state
  Image360State setError(String error) {
    return copyWith(hasError: true, errorMessage: error, isLoading: false);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Image360State &&
        other.currentFrame == currentFrame &&
        other.zoomLevel == zoomLevel &&
        other.panOffset == panOffset &&
        other.isAutoRotating == isAutoRotating &&
        other.rotationDirection == rotationDirection &&
        other.isLoading == isLoading &&
        other.hasError == hasError &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode {
    return Object.hash(
      currentFrame,
      zoomLevel,
      panOffset,
      isAutoRotating,
      rotationDirection,
      isLoading,
      hasError,
      errorMessage,
    );
  }

  @override
  String toString() {
    return 'Image360State('
        'currentFrame: $currentFrame, '
        'zoomLevel: $zoomLevel, '
        'panOffset: $panOffset, '
        'isAutoRotating: $isAutoRotating, '
        'rotationDirection: $rotationDirection, '
        'isLoading: $isLoading, '
        'hasError: $hasError, '
        'errorMessage: $errorMessage'
        ')';
  }
}
