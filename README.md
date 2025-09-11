# Apple Custom Toast Manager

[![Swift](https://img.shields.io/badge/Swift-6.0-orange.svg)](https://swift.org)
[![Platforms](https://img.shields.io/badge/Platforms-iOS%2016%2B%20|%20macOS%2013%2B%20|%20watchOS%209%2B%20|%20visionOS%201%2B-blue.svg)](https://developer.apple.com)
[![SPM Compatible](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)
[![License](https://img.shields.io/github/license/nothing-to-add/apple-custom-toast-manager.svg)](LICENSE)
[![GitHub release](https://img.shields.io/github/release/nothing-to-add/apple-custom-toast-manager.svg)](https://github.com/nothing-to-add/apple-custom-toast-manager/releases)

A modern, customizable toast notification manager for Apple platforms built with SwiftUI. Provides an elegant way to display temporary messages with different types (success, error, warning, info) across iOS, macOS, watchOS, and visionOS applications.

## Features

✨ **Cross-Platform** - Works on iOS 16+, macOS 13+, watchOS 9+, and visionOS 1+  
🎨 **Customizable** - Four built-in toast types with distinct colors and icons  
🔄 **Animated** - Smooth animations for showing and hiding toasts  
📱 **SwiftUI Native** - Built entirely with SwiftUI for modern app development  
⚡ **Easy Integration** - Simple view modifier for quick setup  
🎯 **Singleton Pattern** - Global access through `ToastManager.shared`  
🌐 **Localization Ready** - Uses `LocalizedStringResource` for internationalization  

## Toast Types

| Type | Color | Icon | Use Case |
|------|-------|------|----------|
| `.success` | Green | `checkmark.circle.fill` | Successful operations |
| `.error` | Red | `xmark.circle.fill` | Error messages |
| `.warning` | Orange | `exclamationmark.triangle.fill` | Warnings and alerts |
| `.info` | Blue | `info.circle.fill` | Informational messages |

## Installation

### Swift Package Manager

Add this package to your project using Xcode:

1. Open your project in Xcode
2. Go to **File → Add Package Dependencies...**
3. Enter the repository URL:
   ```
   https://github.com/nothing-to-add/apple-custom-toast-manager
   ```
4. Click **Add Package**

### Package.swift

Add the dependency to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/nothing-to-add/apple-custom-toast-manager.git", from: "1.0.0")
]
```

And add it to your target:

```swift
.target(
    name: "YourTarget",
    dependencies: [
        .product(name: "CustomToastManager", package: "apple-custom-toast-manager")
    ]
)
```

## Quick Start

### 1. Add the Toast Modifier

First, add the toast modifier to your root view:

```swift
import SwiftUI
import CustomToastManager

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .withToast() // Add this modifier
        }
    }
}
```

### 2. Show Toasts

Use the shared `ToastManager` instance to display toasts:

```swift
import SwiftUI
import CustomToastManager

struct ContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            Button("Show Success") {
                ToastManager.shared.showSuccess("Operation completed successfully!")
            }
            
            Button("Show Error") {
                ToastManager.shared.showError("Something went wrong")
            }
            
            Button("Show Warning") {
                ToastManager.shared.showWarning("Please check your input")
            }
            
            Button("Show Info") {
                ToastManager.shared.showInfo("Here's some helpful information")
            }
        }
        .padding()
    }
}
```

## Advanced Usage

### Custom Duration

```swift
// Show a toast for 5 seconds instead of the default 3 seconds
ToastManager.shared.showSuccess("Long message here", duration: 5.0)
```

### Manual Control

```swift
// Show a toast manually
ToastManager.shared.show(
    message: "Custom message",
    type: .info,
    duration: 4.0
)

// Hide the current toast immediately
ToastManager.shared.hide()
```

### Custom Toast View

You can also use the `ToastView` directly if you need more control:

```swift
import SwiftUI
import CustomToastManager

struct CustomContentView: View {
    @State private var showToast = false
    
    var body: some View {
        ZStack {
            VStack {
                Button("Show Custom Toast") {
                    showToast = true
                }
            }
            
            VStack {
                Spacer()
                if showToast {
                    ToastView(
                        message: "Custom toast message",
                        type: .success,
                        isShowing: $showToast
                    )
                    .padding(.bottom, 50)
                }
            }
        }
    }
}
```

## Localization

The package supports localization through `LocalizedStringResource`. You can pass localized strings directly:

```swift
ToastManager.shared.showSuccess("success_message") // Uses your app's string localization
```

## Requirements

- iOS 16.0+ / macOS 13.0+ / watchOS 9.0+ / visionOS 1.0+
- Swift 6.0+
- Xcode 15.0+

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Author

Created by [nothing-to-add](https://github.com/nothing-to-add)

---

⭐ If you find this package helpful, please consider giving it a star on GitHub!
