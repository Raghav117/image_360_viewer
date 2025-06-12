# Image360Viewer Example App

This example app demonstrates all the features of the `image_360_viewer` package.

## 🎥 Video Demonstration

**📱 Demo Video:** [Watch on GitHub](https://github.com/user-attachments/assets/908cbc70-41e8-4c67-9166-1ed6bdc3daa1)

This video demonstrates all the interactive features of the Image360Viewer package using the Under Armour product images included in this example app.

**🎬 Features Shown in Video:**
- Swipe-to-rotate gestures with smooth 360° rotation
- Pinch-to-zoom functionality (1x to 3x zoom levels)
- Auto-rotate with speed controls and direction reversal
- Gyroscope control for device tilt rotation
- Interactive UI controls and real-time property changes

**To experience it yourself:** Run this example app with `flutter run` to interact with all features!

## Features Demonstrated

### 🌐 Network Images Demo
- Loading images from remote URLs
- Auto-rotation with configurable speed
- Pinch-to-zoom functionality
- Loading indicators and error handling
- Cached network images for performance

### 📁 Asset Images Demo  
- Loading image sequences from app assets
- Manual rotation control
- Instructions for setting up local assets
- Code examples for asset configuration

### ⚙️ Advanced Features Demo
- **Gyroscope Control**: Rotate objects by tilting your device
- **Simulated Lighting**: Dynamic shadow effects based on rotation angle
- **Mirror Playback**: Auto-rotation with direction reversal

## Running the Example

1. Ensure you have Flutter installed
2. Navigate to the example directory:
   ```bash
   cd example
   ```
3. Get dependencies:
   ```bash
   flutter pub get
   ```
4. Run the app:
   ```bash
   flutter run
   ```

## Code Examples

### Basic Network Usage
```dart
Image360Viewer.networkList(
  imageUrls: [
    'https://example.com/image1.jpg',
    'https://example.com/image2.jpg',
    // ... more URLs
  ],
  autoRotate: true,
  zoomEnabled: true,
)
```

### Asset Usage
```dart
Image360Viewer.asset(
  assetPath: 'assets/product/frame_',
  frameCount: 24,
  fileExtension: 'jpg',
  autoRotate: true,
  zoomEnabled: true,
)
```

### Advanced Configuration
```dart
Image360Viewer.networkList(
  imageUrls: imageList,
  autoRotate: true,
  reverseOnEnd: true,
  gyroEnabled: true,
  autoRotateSpeed: 150,
  shadowIntensityByFrame: (frameIndex) {
    // Custom lighting calculation
    final angle = (frameIndex / totalFrames) * 2 * pi;
    return (sin(angle) + 1) * 0.3;
  },
)
```

## Navigation

The example app has three main sections accessible via bottom navigation:

1. **Network** - Remote image loading examples
2. **Assets** - Local asset examples (requires setup)
3. **Advanced** - Special features like gyroscope and lighting

## Notes

- The asset demo requires you to add your own image sequence to the `assets/demo/` folder
- Gyroscope features work best on physical devices
- Network demos use placeholder images from picsum.photos 