# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2024-01-20

### Added
- Initial release of Image360Viewer package
- MVVM architecture implementation with separate Models, ViewModels, and Views
- Support for loading images from three sources:
  - Local assets with `Image360Viewer.asset()`
  - Device file system with `Image360Viewer.file()`
  - Network URLs with `Image360Viewer.networkList()`
- Interactive gesture controls:
  - Horizontal swipe to rotate object
  - Pinch-to-zoom functionality
  - Pan to move when zoomed
- Auto-rotation features:
  - Configurable auto-rotate speed
  - Optional reverse direction at end (mirror playback)
  - Start/stop auto-rotation on user interaction
- Gyroscope support for device tilt rotation
- Shadow/lighting simulation with customizable intensity callback
- Optimized image preloading for smooth performance
- Error handling and custom loading/error widgets
- Comprehensive example app demonstrating all features
- Full documentation and API reference
- Platform support for iOS and Android

### Features
- 🔄 **Swipe-to-Rotate**: Natural horizontal gesture rotation
- 🎮 **Gyroscope Support**: Device tilt control (mobile only)
- 🔍 **Pinch-to-Zoom**: Multi-touch zoom with pan support
- 💡 **Simulated Lighting**: Dynamic shadow effects based on rotation angle
- ♻️ **Auto-rotate & Mirror**: Smooth playback with direction reversal
- 📂 **Multi-source Loading**: Assets, files, and network URLs
- 🚀 **Optimized Performance**: Image preloading and caching
- 🎨 **Customizable UI**: Custom loading and error widgets
- 📱 **Mobile-first**: Designed specifically for iOS and Android

### Technical Details
- Uses MVVM architecture pattern for clean separation of concerns
- Built with Flutter 3.7+ and Dart 3.0+
- Dependencies: `cached_network_image` for network image handling, `sensors_plus` for gyroscope support
- Supports all image formats supported by Flutter (JPEG, PNG, GIF, WebP, etc.)
- Optimized for mobile performance with efficient gesture handling
- Null-safe and follows Flutter best practices 