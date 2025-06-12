# 🎯 Image360Viewer

A powerful Flutter package for interactive 360° object rotation with swipe gestures, pinch-to-zoom, and gyroscope support. Built with MVVM architecture for Android, iOS, and Web applications.

Transform static product images into engaging 360° experiences with minimal setup. Perfect for e-commerce, automotive showcases, real estate tours, and any app requiring interactive object inspection.

[![pub package](https://img.shields.io/pub/v/image_360_viewer.svg)](https://pub.dev/packages/image_360_viewer)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Platform](https://img.shields.io/badge/platform-flutter-blue.svg)](https://flutter.dev)

## 🎥 Live Demo

See Image360Viewer in action! Watch how users can interact with 360° product views:

https://github.com/user-attachments/assets/908cbc70-41e8-4c67-9166-1ed6bdc3daa1

> **📱 Interactive Features Shown:**
> - **Swipe to Rotate** - Natural horizontal gestures for smooth 360° rotation
> - **Pinch to Zoom** - Multi-touch zoom from 1x to 3x with pan support
> - **Auto-Rotate** - Automatic rotation with customizable speed and direction
> - **Gyroscope Control** - Device tilt rotation (Android/iOS only) with adjustable sensitivity (0.1x to 3.0x)
> - **Momentum Physics** - Realistic rotation with friction after gesture release

**🎬 To Experience the Demo:**
1. **Watch the video above** to see all features in action
2. **Run the example app:** `cd example && flutter run`
3. **Try it yourself** with the included Under Armour product images

*The demo video showcases all interactive features using 71 optimized product images.*

## 🌟 Key Features

### 🎮 **Advanced Gesture Controls**
- **Swipe-to-Rotate**: Natural horizontal gesture rotation with momentum physics
- **Pinch-to-Zoom**: Multi-touch zoom (1x to 3x) with smooth pan support when zoomed
- **Momentum Rotation**: Realistic physics with friction after gesture release
- **Smart Gesture Detection**: Automatically distinguishes between rotation and zoom gestures
- **Gyroscope Control**: Device tilt rotation (Android/iOS only) with adjustable sensitivity (0.1x to 3.0x)

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
- **Cross-Platform**: Optimized for Android, iOS, and Web applications
- **Reactive Updates**: Real-time state updates with frame change callbacks

## 📦 Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  image_360_viewer: ^1.0.1
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

**🎥 Demo Video:** Watch the complete feature demonstration at [https://github.com/user-attachments/assets/908cbc70-41e8-4c67-9166-1ed6bdc3daa1](https://github.com/user-attachments/assets/908cbc70-41e8-4c67-9166-1ed6bdc3daa1)

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
  gyroEnabled: true,           // Mobile devices (Android/iOS) only
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
| `zoomEnabled` | `bool` | `