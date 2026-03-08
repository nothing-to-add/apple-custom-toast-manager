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
            rootView: ToastView(
                message: message,
                type: type,
                isShowing: .constant(true)
            )
            .padding(.bottom, 50)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        )
        hostingController.view.backgroundColor = .clear
        window.rootViewController = hostingController
        // Use isHidden instead of makeKeyAndVisible to avoid stealing key window status
        window.isHidden = false

        toastWindow = window

        // Auto dismiss
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) { [self] in
            toastWindow?.isHidden = true
            toastWindow = nil
        }
    }
}
