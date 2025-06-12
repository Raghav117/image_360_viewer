library image_360_viewer;

/// A powerful Flutter widget for interactive 360° object rotation with swipe gestures,
/// pinch-to-zoom, and gyroscope support. Load image sequences from assets, files, or network URLs.
///
/// ## Basic Usage
///
/// ```dart
/// // From assets
/// Image360Viewer.asset(
///   imageAssetList: [
///     'assets/sample/1.png',
///     'assets/sample/2.png',
///     // ... more images
///   ],
/// )
///
/// // From network URLs
/// Image360Viewer.networkList(
///   imageUrls: [
///     'https://example.com/image1.jpg',
///     'https://example.com/image2.jpg',
///     // ... more URLs
///   ],
/// )
///
/// // From local files
/// Image360Viewer.file(
///   imageFilePaths: [
///     '/path/to/image1.jpg',
///     '/path/to/image2.jpg',
///     // ... more paths
///   ],
/// )
/// ```
///
/// ## Features
/// - **Interactive Rotation**: Swipe horizontally to rotate the object
/// - **Pinch to Zoom**: Zoom in/out with pinch gestures
/// - **Gyroscope Support**: Rotate by tilting your device
/// - **Auto-Rotation**: Automatic continuous rotation
/// - **Mirror Playback**: Reverse direction at the end of sequence
/// - **Customizable Speed**: Control auto-rotation and gyroscope sensitivity
/// - **Shadow Effects**: Dynamic lighting simulation
/// - **Multiple Sources**: Assets, files, or network images

// Export the main widget
export 'src/views/image_360_viewer.dart';

// Export models for configuration
export 'src/models/image_360_config.dart';
export 'src/models/image_360_state.dart';

// Export view model for advanced usage
export 'src/viewmodels/image_360_viewmodel.dart';
