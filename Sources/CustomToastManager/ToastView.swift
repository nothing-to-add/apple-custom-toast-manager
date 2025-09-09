//
//  File name: ToastView.swift
//  Project name: apple-custom-toast-manager
//  Workspace name: apple-custom-toast-manager
//
//  Created by: nothing-to-add on 09/09/2025
//  Using Swift 6.0
//  Copyright (c) 2023 nothing-to-add
//

import SwiftUI

struct ToastView: View {
    let message: LocalizedStringResource
    let type: ToastType
    @Binding var isShowing: Bool
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: type.icon)
                .foregroundColor(type.color)
                .font(.system(size: 20))
            
            Text(message)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.primary)
                .multilineTextAlignment(.leading)
            
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemBackground))
                .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(type.color.opacity(0.3), lineWidth: 1)
        )
        .padding(.horizontal, 16)
        .transition(.asymmetric(
            insertion: .move(edge: .bottom).combined(with: .opacity),
            removal: .move(edge: .bottom).combined(with: .opacity)
        ))
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.3)) {
                isShowing = false
            }
        }
    }
}

#Preview("Error Toast") {
    ToastView(
        message: "No user available to save dark mode preference",
        type: .error,
        isShowing: .constant(true)
    )
    .padding()
    .background(Color.gray.opacity(0.1))
}

#Preview("Success Toast") {
    ToastView(
        message: "Settings saved successfully",
        type: .success,
        isShowing: .constant(true)
    )
    .padding()
    .background(Color.gray.opacity(0.1))
}

#Preview("Warning Toast") {
    ToastView(
        message: "Please check your internet connection",
        type: .warning,
        isShowing: .constant(true)
    )
    .padding()
    .background(Color.gray.opacity(0.1))
}
