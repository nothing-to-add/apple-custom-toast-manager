//
//  File name: ToastWindowManager.swift
//  Project name: apple-custom-toast-manager
//  Workspace name: apple-custom-toast-manager
//
//  Created by: nothing-to-add on 08/03/2026
//  Using Swift 6.0
//  Copyright (c) 2023 nothing-to-add
//

import UIKit
import SwiftUI

// MARK: - Animated wrapper

private struct ToastContainerView: View {
    let message: LocalizedStringResource
    let type: ToastType
    let duration: TimeInterval
    let onDismiss: () -> Void

    @State private var isVisible: Bool = false

    var body: some View {
        ZStack(alignment: .bottom) {
            if isVisible {
                ToastView(
                    message: message,
                    type: type,
                    isShowing: Binding(
                        get: { isVisible },
                        set: { newValue in
                            if !newValue { dismiss() }
                        }
                    )
                )
                .padding(.bottom, 50)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .onAppear {
            withAnimation(.spring(response: 0.4, dampingFraction: 0.75)) {
                isVisible = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                dismiss()
            }
        }
    }

    private func dismiss() {
        withAnimation(.easeInOut(duration: 0.3)) {
            isVisible = false
        }
        // Allow the animation to finish before removing the window
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
            onDismiss()
        }
    }
}

// MARK: - Window manager

@MainActor
public final class ToastWindowManager {
    public static let shared = ToastWindowManager()

    private var toastWindow: UIWindow?

    public func show(message: LocalizedStringResource, type: ToastType, duration: TimeInterval = 3.0) {
        let windowScene = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first

        guard let windowScene else { return }

        let window = UIWindow(windowScene: windowScene)
        window.windowLevel = .alert + 1  // Above everything, including sheets
        window.backgroundColor = .clear
        window.isUserInteractionEnabled = false

        let hostingController = UIHostingController(
            rootView: ToastContainerView(
                message: message,
                type: type,
                duration: duration,
                onDismiss: { [weak self] in
                    self?.toastWindow?.isHidden = true
                    self?.toastWindow = nil
                }
            )
        )
        hostingController.view.backgroundColor = .clear
        window.rootViewController = hostingController
        // Use isHidden instead of makeKeyAndVisible to avoid stealing key window status
        window.isHidden = false

        toastWindow = window
    }
}
