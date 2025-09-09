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
public class ToastManager: ObservableObject {
    public static let shared = ToastManager()
    
    @Published public var isShowing = false
    @Published public var message: LocalizedStringResource = ""
    @Published public var type: ToastType = .info
    
    private var workItem: DispatchWorkItem?
    
    private init() {}
    
    /// Show a toast message
    /// - Parameters:
    ///   - message: The message to display
    ///   - type: The type of toast (success, error, warning, info)
    ///   - duration: How long to show the toast (default: 3 seconds)
    public func show(message: LocalizedStringResource, type: ToastType, duration: TimeInterval = 3.0) {
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
    public func hide() {
        workItem?.cancel()
        withAnimation(.easeInOut(duration: 0.3)) {
            isShowing = false
        }
    }
    
    // MARK: - Convenience Methods
    
    /// Show an error toast
    public func showError(_ message: LocalizedStringResource, duration: TimeInterval = 3.0) {
        show(message: message, type: .error, duration: duration)
    }
    
    /// Show a success toast
    public func showSuccess(_ message: LocalizedStringResource, duration: TimeInterval = 3.0) {
        show(message: message, type: .success, duration: duration)
    }
    
    /// Show a warning toast
    public func showWarning(_ message: LocalizedStringResource, duration: TimeInterval = 3.0) {
        show(message: message, type: .warning, duration: duration)
    }
    
    /// Show an info toast
    public func showInfo(_ message: LocalizedStringResource, duration: TimeInterval = 3.0) {
        show(message: message, type: .info, duration: duration)
    }
}
