//
//  File name: ToastViewModifier.swift
//  Project name: apple-custom-toast-manager
//  Workspace name: apple-custom-toast-manager
//
//  Created by: nothing-to-add on 09/09/2025
//  Using Swift 6.0
//  Copyright (c) 2023 nothing-to-add
//

import SwiftUI

public struct ToastViewModifier: ViewModifier {
    @ObservedObject private var toastManager = ToastManager.shared
    
    public init() {}
    
    public func body(content: Content) -> some View {
        content
            .onChange(of: toastManager.isShowing) { _, isShowing in
                if isShowing {
                    ToastWindowManager.shared.show(
                        message: toastManager.message,
                        type: toastManager.type,
                        duration: 3.0
                    )
                }
            }
    }
}

public extension View {
    /// Add toast notifications to any view
    func withToast() -> some View {
        modifier(ToastViewModifier())
    }
}
