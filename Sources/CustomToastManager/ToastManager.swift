//
//  File name: ToastManager.swift
//  Project name: apple-custom-toast-manager
//  Workspace name: apple-custom-toast-manager
//
//  Created by: nothing-to-add on 09/09/2025
//  Using Swift 6.0
//  Copyright (c) 2023 nothing-to-add
//

import SwiftUI

@MainActor
class ToastManager: ObservableObject {
    static let shared = ToastManager()
    
    @Published var isShowing = false
    @Published var message: LocalizedStringResource = ""
    @Published var type: ToastType = .info
    
    private var workItem: DispatchWorkItem?
    
    private init() {}
    
    /// Show a toast message
    /// - Parameters:
    ///   - message: The message to display
    ///   - type: The type of toast (success, error, warning, info)
    ///   - duration: How long to show the toast (default: 3 seconds)
    func show(message: LocalizedStringResource, type: ToastType, duration: TimeInterval = 3.0) {
        // Cancel any existing work item
        workItem?.cancel()
        
        // Update the toast content
        self.message = message
        self.type = type
        
        // Show the toast with animation
        withAnimation(.easeInOut(duration: 0.3)) {
            isShowing = true
        }
        
        // Create new work item to hide the toast
        workItem = DispatchWorkItem { [weak self] in
            withAnimation(.easeInOut(duration: 0.3)) {
                self?.isShowing = false
            }
        }
        
        // Schedule the work item
        DispatchQueue.main.asyncAfter(deadline: .now() + duration, execute: workItem!)
    }
    
    /// Hide the toast immediately
    func hide() {
        workItem?.cancel()
        withAnimation(.easeInOut(duration: 0.3)) {
            isShowing = false
        }
    }
    
    // MARK: - Convenience Methods
    
    /// Show an error toast
    func showError(_ message: LocalizedStringResource, duration: TimeInterval = 3.0) {
        show(message: message, type: .error, duration: duration)
    }
    
    /// Show a success toast
    func showSuccess(_ message: LocalizedStringResource, duration: TimeInterval = 3.0) {
        show(message: message, type: .success, duration: duration)
    }
    
    /// Show a warning toast
    func showWarning(_ message: LocalizedStringResource, duration: TimeInterval = 3.0) {
        show(message: message, type: .warning, duration: duration)
    }
    
    /// Show an info toast
    func showInfo(_ message: LocalizedStringResource, duration: TimeInterval = 3.0) {
        show(message: message, type: .info, duration: duration)
    }
}
