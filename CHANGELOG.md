# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.2] - 2025-01-27

### Added
- 🔧 **Java 17 Support**: Updated Android build configuration to use Java 17 for better compatibility
- 🚀 **Kotlin 2.1.0 Support**: Upgraded Kotlin version from 1.8.22 to 2.1.0 for latest language features

### Changed
- 📦 **Dependencies Updated**:
  - `sensors_plus`: 6.1.1 → 7.0.0 (latest major version)
  - `flutter_lints`: 4.0.0 → 6.0.0 (latest linting rules)
  - All transitive dependencies updated to latest compatible versions
- 🏗️ **Android Configuration**:
  - Updated Java compatibility from Java 11 to Java 17
  - Fixed Android namespace duplication issue
  - Updated Kotlin target to Java 17
  - Upgraded Kotlin version from 1.8.22 to 2.1.0
- 📝 **Code Quality**:
  - Fixed linting issues and improved code analysis
  - Removed unnecessary library declarations
  - Enhanced documentation structure

### Fixed
- 🐛 **Android Package Naming**: Fixed duplicated namespace in Android configuration
- 🧹 **Code Analysis**: Resolved all linting warnings and errors
- 📱 **Build Compatibility**: Ensured compatibility with latest Android development tools

### Technical Details
- **SDK Requirements**: `sdk: '>=3.0.0 <4.0.0'` (maintained original minimum)
- **Flutter Requirements**: `flutter: ">=3.10.0"` (maintained original minimum)
- **Android Java Version**: Java 17
- **Kotlin Version**: 2.1.0 (upgraded from 1.8.22)
- **All Dependencies**: Updated to latest compatible versions

## [1.0.1] - 2024-01-20

### Added
- 🎥 **Embedded Video Demo**: Added GitHub-hosted video demonstration that plays directly in README.md
- 📺 **Interactive Demo URL**: Integrated video URL `https://github.com/user-attachments/assets/908cbc70-41e8-4c67-9166-1ed6bdc3daa1`
- 🎬 **Enhanced Documentation**: Improved README.md with better video presentation and user experience
- 🌐 **Web Platform Support**: Added official Web platform support alongside Android and iOS

### Changed
- 📖 **README.md Updates**: 
  - Replaced local video file reference with GitHub-hosted video URL
  - Enhanced "Live Demo" section with embedded video player
  - Improved "Example App & Demo" section with clickable video link
  - Updated example README.md with consistent video references
  - Clarified platform support: Android, iOS, and Web
  - Updated gyroscope feature descriptions to specify mobile-only (Android/iOS)
- 🔗 **Better User Experience**: Video now plays directly in GitHub README without requiring file downloads
- 📱 **Mobile-Friendly**: Video demonstration works seamlessly on mobile GitHub interface

### Technical
- Video hosted on GitHub CDN for fast loading and reliability
- Added Web platform to pubspec.yaml platforms section
- Maintained backward compatibility with all existing features
- No breaking changes to API or functionality

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