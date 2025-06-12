# 🎯 Image360Viewer

A powerful Flutter package for interactive 360° object rotation with swipe gestures, pinch-to-zoom, and gyroscope support. Built with MVVM architecture for iOS and Android applications.

Transform static product images into engaging 360° experiences with minimal setup. Perfect for e-commerce, automotive showcases, real estate tours, and any app requiring interactive object inspection.

[![pub package](https://img.shields.io/pub/v/image_360_viewer.svg)](https://pub.dev/packages/image_360_viewer)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Platform](https://img.shields.io/badge/platform-flutter-blue.svg)](https://flutter.dev)

## 🎥 Live Demo

See Image360Viewer in action! Watch how users can interact with 360° product views:

**📱 Demo Video Location:** `example/assets/image_360_viewer.mp4`

> **📱 Interactive Features Shown:**
> - **Swipe to Rotate** - Natural horizontal gestures for smooth 360° rotation
> - **Pinch to Zoom** - Multi-touch zoom from 1x to 3x with pan support
> - **Auto-Rotate** - Automatic rotation with customizable speed and direction
> - **Gyroscope Control** - Device tilt rotation for immersive mobile experience
> - **Momentum Physics** - Realistic rotation with friction after gesture release

**🎬 To View the Demo:**
1. Clone this repository
2. Navigate to `example/assets/image_360_viewer.mp4`
3. Or run the example app: `cd example && flutter run`

*The demo video showcases all features using the included Under Armour product images.*

## 🌟 Key Features

### 🎮 **Advanced Gesture Controls**
- **Swipe-to-Rotate**: Natural horizontal gesture rotation with momentum physics
- **Pinch-to-Zoom**: Multi-touch zoom (1x to 3x) with smooth pan support when zoomed
- **Momentum Rotation**: Realistic physics with friction after gesture release
- **Smart Gesture Detection**: Automatically distinguishes between rotation and zoom gestures
- **Gyroscope Control**: Device tilt rotation (mobile only) with adjustable sensitivity (0.1x to 3.0x)

### 📂 **Flexible Image Loading System**
- **Asset Images**: Load from app bundle with List<String> for complete control
- **Network URLs**: Load from web with built-in caching via CachedNetworkImage
- **File System**: Load from device storage with full file path control
- **Smart Preloading**: Automatic image preloading and caching for smooth playback
- **Error Handling**: Robust error handling with custom error widgets per source type

### 🎨 **Visual Enhancement Features**
- **Dynamic Shadow System**: Programmable lighting effects based on rotation angle
- **Custom UI Components**: Configurable loading and error widgets
- **Background Control**: Customizable background colors and transparency
- **Smooth Animations**: Optimized frame transitions with configurable speed
- **Transform Controls**: Scale and translate transforms with bounds checking

### 🔄 **Advanced Playback Controls**
- **Auto-Rotate**: Smooth automatic playback with customizable speed (milliseconds)
- **Mirror Playback**: Reverse direction at end for seamless back-and-forth loops
- **Direction Control**: Forward/backward rotation with dynamic direction switching
- **Frame Control**: Jump to specific frames, loop handling, and bounds management
- **Playback State**: Real-time state tracking (playing, paused, direction, frame)

### 🚀 **Performance & Architecture**
- **MVVM Architecture**: Clean separation with Model-View-ViewModel pattern
- **Memory Management**: Efficient image disposal and cleanup
- **State Management**: Immutable state with ChangeNotifier pattern
- **Mobile-First**: Optimized specifically for iOS and Android performance
- **Reactive Updates**: Real-time state updates with frame change callbacks

## 📦 Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  image_360_viewer: ^1.0.0
```

Then run:

```bash
flutter pub get
```

## 🚀 Quick Start

### Basic Usage

```dart
import 'package:image_360_viewer/image_360_viewer.dart';

// Simple 360° viewer with network images
Image360Viewer.networkList(
  imageUrls: [
    'https://example.com/product/frame_01.jpg',
    'https://example.com/product/frame_02.jpg',
    'https://example.com/product/frame_03.jpg',
    // ... more frames for smooth rotation
  ],
  autoRotate: true,
  zoomEnabled: true,
)
```

### Asset Images with Complete Control

```dart
// Load sequential asset images with full control
Image360Viewer.asset(
  imageAssetList: [
    'assets/product/frame_01.jpg',
    'assets/product/frame_02.jpg',
    'assets/product/frame_03.jpg',
    // ... up to frame_36.jpg for full 360°
  ],
  autoRotate: true,
  zoomEnabled: true,
  gyroEnabled: true,
  gyroSensitivity: 1.5,  // Enhanced gyroscope responsiveness
)
```

## 📱 Example App & Demo

The package includes a comprehensive example app that showcases all features:

```bash
# Run the example app
cd example
flutter pub get
flutter run
```

**🎥 Demo Video:** The example app includes a demo video (`example/assets/image_360_viewer.mp4`) showing all interactive features in action with real Under Armour product images.

**🖼️ Sample Images:** 71 optimized Under Armour product images (500px width) are included for immediate testing and demonstration.

## 📱 Real-World Use Cases

### 🛍️ **E-commerce Product Views**
```dart
// Perfect for online stores with frame change tracking
Image360Viewer.networkList(
  imageUrls: productImageUrls,
  autoRotate: false,           // Let users control rotation
  zoomEnabled: true,           // Allow detailed inspection
  backgroundColor: Colors.white,
  onFrameChanged: (frameIndex) {
    // Track user interaction analytics
    print('User viewing angle: $frameIndex');
  },
  loadingWidget: Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(),
        SizedBox(height: 16),
        Text('Loading product view...'),
      ],
    ),
  ),
)
```

### 🚗 **Automotive Showcases**
```dart
// Car dealership virtual showroom with dynamic lighting
Image360Viewer.asset(
  imageAssetList: carExteriorImages,
  autoRotate: true,
  autoRotateSpeed: 800,        // Slower for dramatic effect
  reverseOnEnd: true,          // Smooth back-and-forth
  zoomEnabled: true,
  shadowIntensityByFrame: (frameIndex) {
    // Simulate showroom lighting that follows the car
    final angle = (frameIndex / carExteriorImages.length) * 2 * math.pi;
    return (math.sin(angle) + 1) * 0.2;
  },
)
```

### 🏠 **Real Estate Virtual Tours**
```dart
// Room or property exterior views with gyroscope
Image360Viewer.file(
  imageFilePaths: roomImagePaths,
  autoRotate: false,
  zoomEnabled: true,
  gyroEnabled: true,           // Immersive mobile experience
  gyroSensitivity: 1.5,        // Responsive tilt control
  backgroundColor: Colors.black,
  onFrameChanged: (frameIndex) {
    // Update room information based on viewing angle
    updateRoomInfo(frameIndex);
  },
)
```

### 🎓 **Educational 3D Models**
```dart
// Interactive learning materials with error handling
Image360Viewer.networkList(
  imageUrls: anatomyModelUrls,
  autoRotate: true,
  autoRotateSpeed: 1200,       // Slow for study
  zoomEnabled: true,
  initialFrame: 0,             // Start from front view
  errorWidget: Container(
    padding: EdgeInsets.all(20),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.school, size: 48, color: Colors.grey),
        Text('Model temporarily unavailable'),
        ElevatedButton(
          onPressed: () => retryLoading(),
          child: Text('Retry'),
        ),
      ],
    ),
  ),
)
```

## ⚙️ Advanced Configuration

### Complete Feature Showcase

```dart
import 'dart:math' as math;

Image360Viewer.networkList(
  imageUrls: imageUrlList,
  
  // Rotation Controls
  autoRotate: true,
  autoRotateSpeed: 600,        // Milliseconds between frames
  reverseOnEnd: true,          // Mirror playback
  initialFrame: 0,             // Starting position
  
  // Interaction Controls
  zoomEnabled: true,           // Pinch-to-zoom (1x to 3x)
  gyroEnabled: true,           // Device tilt control
  gyroSensitivity: 1.2,        // Gyroscope responsiveness (0.1 to 3.0)
  
  // Visual Customization
  width: double.infinity,
  height: 300,
  backgroundColor: Colors.grey.shade100,
  
  // Frame Change Callback
  onFrameChanged: (frameIndex) {
    print('Current frame: $frameIndex');
    // Update UI, analytics, or other components
  },
  
  // Dynamic Lighting Effect
  shadowIntensityByFrame: (frameIndex) {
    final normalizedIndex = frameIndex / imageUrlList.length;
    final angle = normalizedIndex * 2 * math.pi;
    // Creates a shadow that moves around the object
    return (math.sin(angle) + 1) * 0.3; // 0.0 to 0.6 opacity
  },
  
  // Custom UI Components
  loadingWidget: Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black12)],
    ),
    padding: EdgeInsets.all(20),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircularProgressIndicator(strokeWidth: 2),
        SizedBox(height: 12),
        Text('Loading 360° view...', style: TextStyle(fontSize: 14)),
      ],
    ),
  ),
  
  errorWidget: Container(
    padding: EdgeInsets.all(20),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.error_outline, size: 48, color: Colors.red),
        SizedBox(height: 12),
        Text('Failed to load 360° view'),
        SizedBox(height: 8),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Go Back'),
        ),
      ],
    ),
  ),
)
```

## 📌 Complete API Reference

### Constructor Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| **Required Parameters** |
| `imageAssetList` | `List<String>` | - | **[asset()]** List of asset paths for image sequence |
| `imageFilePaths` | `List<String>` | - | **[file()]** List of file paths for image sequence |
| `imageUrls` | `List<String>` | - | **[networkList()]** List of network URLs for image sequence |
| **Rotation Control** |
| `autoRotate` | `bool` | `false` | Enable automatic rotation on start |
| `autoRotateSpeed` | `int` | `100` | Milliseconds between auto-rotation frames |
| `reverseOnEnd` | `bool` | `false` | Reverse rotation direction after completing full loop |
| `initialFrame` | `int` | `0` | Starting frame index (0-based) |
| **Interaction Control** |
| `zoomEnabled` | `bool` | `true` | Enable pinch-to-zoom and pan gestures (1x to 3x zoom) |
| `gyroEnabled` | `bool` | `false` | Enable device gyroscope rotation control |
| `gyroSensitivity` | `double` | `1.0` | Gyroscope sensitivity multiplier (0.1 - 3.0) |
| **Visual Customization** |
| `width` | `double?` | `null` | Widget width (uses available space if null) |
| `height` | `double?` | `null` | Widget height (uses available space if null) |
| `backgroundColor` | `Color` | `Colors.transparent` | Background color behind images |
| `shadowIntensityByFrame` | `double Function(int)?` | `null` | Dynamic shadow opacity (0.0-1.0) based on frame |
| **UI Customization** |
| `loadingWidget` | `Widget?` | `null` | Custom widget shown while loading images |
| `errorWidget` | `Widget?` | `null` | Custom widget shown on loading errors |
| **Callbacks** |
| `onFrameChanged` | `Function(int frameIndex)?` | `null` | Callback fired when frame changes (for analytics/UI updates) |
| **Flutter Framework** |
| `key` | `Key?` | `null` | Widget key for Flutter framework |

### Available Constructors

#### 🗂️ `Image360Viewer.asset()`
Load sequential images from app assets:

```dart
Image360Viewer.asset(
  // Required
  imageAssetList: [
    'assets/product/angle_01.jpg',
    'assets/product/angle_02.jpg',
    'assets/product/angle_03.jpg',
    // ... more sequential frames
  ],
  
  // Rotation Control
  autoRotate: false,
  autoRotateSpeed: 100,
  reverseOnEnd: false,
  initialFrame: 0,
  
  // Interaction Control
  zoomEnabled: true,
  gyroEnabled: false,
  gyroSensitivity: 1.0,
  
  // Visual Customization
  width: null,
  height: null,
  backgroundColor: Colors.transparent,
  shadowIntensityByFrame: null,
  
  // UI Customization
  loadingWidget: null,
  errorWidget: null,
  
  // Callbacks
  onFrameChanged: null,
  
  // Flutter Framework
  key: null,
)
```

**Best for**: Bundled product images, offline experiences, consistent loading times.

#### 🌐 `Image360Viewer.networkList()`
Load images from web URLs with caching:

```dart
Image360Viewer.networkList(
  // Required
  imageUrls: [
    'https://cdn.example.com/product/frame_01.jpg',
    'https://cdn.example.com/product/frame_02.jpg',
    'https://cdn.example.com/product/frame_03.jpg',
    // ... more URLs
  ],
  
  // Rotation Control
  autoRotate: false,
  autoRotateSpeed: 100,
  reverseOnEnd: false,
  initialFrame: 0,
  
  // Interaction Control
  zoomEnabled: true,
  gyroEnabled: false,
  gyroSensitivity: 1.0,
  
  // Visual Customization
  width: null,
  height: null,
  backgroundColor: Colors.transparent,
  shadowIntensityByFrame: null,
  
  // UI Customization
  loadingWidget: null,
  errorWidget: null,
  
  // Callbacks
  onFrameChanged: null,
  
  // Flutter Framework
  key: null,
)
```

**Best for**: Dynamic content, CDN-hosted images, real-time product catalogs.
**Features**: Built-in caching via CachedNetworkImage, automatic retry logic.

#### 📁 `Image360Viewer.file()`
Load images from device file system:

```dart
Image360Viewer.file(
  // Required
  imageFilePaths: [
    '/storage/emulated/0/Pictures/scan_01.jpg',
    '/storage/emulated/0/Pictures/scan_02.jpg',
    '/storage/emulated/0/Pictures/scan_03.jpg',
    // ... more file paths
  ],
  
  // Rotation Control
  autoRotate: false,
  autoRotateSpeed: 100,
  reverseOnEnd: false,
  initialFrame: 0,
  
  // Interaction Control
  zoomEnabled: true,
  gyroEnabled: false,
  gyroSensitivity: 1.0,
  
  // Visual Customization
  width: null,
  height: null,
  backgroundColor: Colors.transparent,
  shadowIntensityByFrame: null,
  
  // UI Customization
  loadingWidget: null,
  errorWidget: null,
  
  // Callbacks
  onFrameChanged: null,
  
  // Flutter Framework
  key: null,
)
```

**Best for**: User-generated content, camera captures, downloaded images.

## 🎨 Advanced Customization

### Creating Dynamic Lighting Effects

Simulate realistic lighting that changes as the object rotates:

```dart
// Spotlight effect from the right
shadowIntensityByFrame: (frameIndex) {
  final progress = frameIndex / totalFrames;
  final angle = progress * 2 * math.pi;
  
  // Spotlight from 90° (right side)
  final lightAngle = math.pi / 2;
  final difference = (angle - lightAngle).abs();
  final normalizedDiff = math.min(difference, 2 * math.pi - difference);
  
  // Stronger shadow when facing away from light
  return math.sin(normalizedDiff) * 0.4;
}

// Overhead lighting effect
shadowIntensityByFrame: (frameIndex) {
  final progress = frameIndex / totalFrames;
  final angle = progress * 2 * math.pi;
  
  // Simulate overhead light creating bottom shadows
  return (math.cos(angle) + 1) * 0.25; // 0.0 to 0.5 opacity
}

// Dramatic side lighting
shadowIntensityByFrame: (frameIndex) {
  final progress = frameIndex / totalFrames;
  final angle = progress * 4 * math.pi; // Double frequency for more dramatic effect
  
  return (math.sin(angle).abs()) * 0.6; // 0.0 to 0.6 opacity
}
```

### Frame Change Tracking & Analytics

```dart
Image360Viewer.networkList(
  imageUrls: productImages,
  onFrameChanged: (frameIndex) {
    // Analytics tracking
    analytics.track('product_360_view', {
      'frame': frameIndex,
      'angle': (frameIndex / productImages.length) * 360,
      'product_id': productId,
    });
    
    // Update UI elements
    setState(() {
      currentAngle = (frameIndex / productImages.length) * 360;
      viewingDirection = getDirectionFromAngle(currentAngle);
    });
    
    // Trigger haptic feedback at key angles
    if (frameIndex % (productImages.length ~/ 4) == 0) {
      HapticFeedback.lightImpact();
    }
  },
)
```

### Custom Loading States

Create branded loading experiences:

```dart
loadingWidget: Container(
  decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [Colors.blue.shade100, Colors.blue.shade50],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(12),
  ),
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      // Custom animated loader
      SizedBox(
        width: 40,
        height: 40,
        child: CircularProgressIndicator(
          strokeWidth: 3,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
        ),
      ),
      SizedBox(height: 16),
      Text(
        'Preparing 360° Experience',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.blue.shade800,
        ),
      ),
      SizedBox(height: 8),
      Text(
        'Loading high-quality images...',
        style: TextStyle(
          fontSize: 12,
          color: Colors.blue.shade600,
        ),
      ),
    ],
  ),
)
```

## 🔧 Performance Tips

### Image Optimization
- **Recommended size**: 500-800px width for mobile devices
- **Format**: JPEG for photos, PNG for graphics with transparency
- **Frame count**: 24-36 frames for smooth rotation, 12-18 for faster loading
- **Compression**: Balance quality vs file size (80-90% JPEG quality)

### Memory Management
```dart
// The widget automatically handles image disposal
// No manual cleanup required

// For large image sets, consider reducing frame count:
Image360Viewer.networkList(
  imageUrls: everySecondFrame, // Use every 2nd frame instead of all
  autoRotateSpeed: 200,        // Adjust speed to maintain smoothness
)
```

### Network Loading Best Practices
```dart
Image360Viewer.networkList(
  imageUrls: imageUrls,
  loadingWidget: YourLoadingWidget(),
  errorWidget: YourErrorWidget(),
  
  // Images are automatically cached by CachedNetworkImage
  // Consider preloading critical images in your app initialization
)
```

## 🎯 Custom Features Highlights

### 🔄 **Smart Gesture System**
- **Momentum Physics**: Realistic rotation with friction after gesture release
- **Gesture Separation**: Automatically distinguishes between rotation and zoom
- **Zoom Bounds**: Controlled zoom limits (1x to 3x) with smooth transitions
- **Pan Support**: Pan images when zoomed in for detailed inspection

### 🎮 **Advanced Gyroscope Integration**
- **Configurable Sensitivity**: Adjust gyroscope responsiveness (0.1x to 3.0x)
- **Y-axis Rotation**: Uses device Y-axis for natural horizontal spinning
- **Real-time Updates**: Smooth real-time rotation based on device tilt

### 🔄 **Intelligent Auto-Rotation**
- **Direction Control**: Forward/backward rotation with dynamic switching
- **Mirror Playback**: Seamless back-and-forth loops for continuous viewing
- **Smart Pausing**: Auto-pause during user interaction, auto-resume after delay
- **Speed Control**: Configurable rotation speed in milliseconds

### 🎨 **Dynamic Shadow System**
- **Frame-based Lighting**: Programmable shadows based on current frame
- **Realistic Effects**: Simulate various lighting conditions (spotlight, overhead, side)
- **Performance Optimized**: Efficient shadow rendering with customizable intensity

### 📊 **State Management & Callbacks**
- **Real-time State**: Track current frame, zoom level, rotation direction
- **Frame Change Events**: Callbacks for analytics, UI updates, and user tracking
- **Error Handling**: Comprehensive error states with custom error widgets
- **Loading States**: Detailed loading states with custom loading widgets

## 🐛 Troubleshooting

### Common Issues

**Images not loading from assets:**
```yaml
# Ensure pubspec.yaml includes your assets
flutter:
  assets:
    - assets/product/
```

**Gyroscope not working:**
- Gyroscope only works on physical devices, not simulators
- Ensure device has gyroscope sensor
- Check device orientation permissions

**Performance issues:**
- Reduce image dimensions (recommended: 500-800px width)
- Decrease frame count for faster loading
- Use JPEG format for smaller file sizes

**Network images failing:**
- Check internet connectivity
- Verify image URLs are accessible
- Implement proper error handling with `errorWidget`

**Zoom/Pan not working:**
- Ensure `zoomEnabled: true` is set
- Check if custom gesture detectors are interfering
- Verify the widget has sufficient size constraints

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

## 📞 Support

- 📧 **Issues**: [GitHub Issues](https://github.com/raghavg1999/image_360_viewer/issues)
- 📖 **Documentation**: [pub.dev](https://pub.dev/packages/image_360_viewer)
- 💬 **Discussions**: [GitHub Discussions](https://github.com/raghavg1999/image_360_viewer/discussions)

---

**Made with ❤️ for the Flutter community**

Transform your static images into engaging 360° experiences today!
