# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.1.0] - 2026-03-08

### Added
- `ToastWindowManager` for rendering toasts in a dedicated `UIWindow` overlay, displayed above all content including sheets and modals
- Animated toast appearance using a spring animation (slide-in from bottom)
- Animated toast dismissal using an ease-in-out animation (slide-out to bottom with opacity fade)
- Tap-to-dismiss support with animated removal

### Changed
- Toast is now rendered in its own `UIWindow` layer instead of inside the SwiftUI view hierarchy, ensuring it always appears on top
- `ToastViewModifier` now delegates presentation to `ToastWindowManager`
- Auto-dismiss timer is handled inside the animated container, allowing the exit animation to complete before the window is removed

## [1.0.0] - 2025-09-10

### Added
- Initial release of CustomToastManager
- ToastManager for displaying custom toast notifications
- ToastView for rendering toast messages
- ToastType enum for different toast styles
- ToastViewModifier for SwiftUI integration
- Support for iOS 16+, macOS 13+, watchOS 9+, and visionOS 1+

### Features
- Easy-to-use toast notification system
- Customizable toast types and styles
- SwiftUI integration with view modifiers
- Cross-platform support for Apple devices
