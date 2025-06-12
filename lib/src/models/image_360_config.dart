import 'package:flutter/material.dart' show Color;

/// Configuration model for Image360Viewer
class Image360Config {
  /// List of asset paths for loading image sequences from assets
  final List<String>? imageAssetList;

  /// List of file paths for loading from device storage
  final List<String>? imageFilePaths;

  /// List of network URLs for loading remote images
  final List<String>? imageUrls;

  /// Whether to automatically rotate the object on start
  final bool autoRotate;

  /// Whether to enable pinch-to-zoom functionality
  final bool zoomEnabled;

  /// Whether to enable gyroscope rotation
  final bool gyroEnabled;

  /// Sensitivity multiplier for gyroscope rotation (0.1 to 3.0)
  final double gyroSensitivity;

  /// Whether to reverse rotation direction after completing a full loop
  final bool reverseOnEnd;

  /// Speed of auto-rotation (milliseconds between frames)
  final int autoRotateSpeed;

  /// Initial frame index to display
  final int initialFrame;

  /// Width of the viewer widget
  final double? width;

  /// Height of the viewer widget
  final double? height;

  /// Background color of the viewer
  final Color backgroundColor;

  /// Image source type
  final ImageSourceType sourceType;

  const Image360Config({
    this.imageAssetList,
    this.imageFilePaths,
    this.imageUrls,
    this.autoRotate = false,
    this.zoomEnabled = true,
    this.gyroEnabled = false,
    this.gyroSensitivity = 1.0,
    this.reverseOnEnd = false,
    this.autoRotateSpeed = 100,
    this.initialFrame = 0,
    this.width,
    this.height,
    required this.backgroundColor,
    required this.sourceType,
  });

  /// Factory constructor for asset-based configuration
  factory Image360Config.asset({
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
    Color backgroundColor = const Color(0x00000000), // Colors.transparent
  }) {
    return Image360Config(
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
      sourceType: ImageSourceType.asset,
    );
  }

  /// Factory constructor for file-based configuration
  factory Image360Config.file({
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
    Color backgroundColor = const Color(0x00000000), // Colors.transparent
  }) {
    return Image360Config(
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
      sourceType: ImageSourceType.file,
    );
  }

  /// Factory constructor for network-based configuration
  factory Image360Config.network({
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
    Color backgroundColor = const Color(0x00000000), // Colors.transparent
  }) {
    return Image360Config(
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
      sourceType: ImageSourceType.network,
    );
  }

  /// Copy with method for immutable updates
  Image360Config copyWith({
    List<String>? imageAssetList,
    List<String>? imageFilePaths,
    List<String>? imageUrls,
    bool? autoRotate,
    bool? zoomEnabled,
    bool? gyroEnabled,
    double? gyroSensitivity,
    bool? reverseOnEnd,
    int? autoRotateSpeed,
    int? initialFrame,
    double? width,
    double? height,
    Color? backgroundColor,
    ImageSourceType? sourceType,
  }) {
    return Image360Config(
      imageAssetList: imageAssetList ?? this.imageAssetList,
      imageFilePaths: imageFilePaths ?? this.imageFilePaths,
      imageUrls: imageUrls ?? this.imageUrls,
      autoRotate: autoRotate ?? this.autoRotate,
      zoomEnabled: zoomEnabled ?? this.zoomEnabled,
      gyroEnabled: gyroEnabled ?? this.gyroEnabled,
      gyroSensitivity: gyroSensitivity ?? this.gyroSensitivity,
      reverseOnEnd: reverseOnEnd ?? this.reverseOnEnd,
      autoRotateSpeed: autoRotateSpeed ?? this.autoRotateSpeed,
      initialFrame: initialFrame ?? this.initialFrame,
      width: width ?? this.width,
      height: height ?? this.height,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      sourceType: sourceType ?? this.sourceType,
    );
  }
}

/// Image source type for the 360 viewer
enum ImageSourceType { asset, file, network }
