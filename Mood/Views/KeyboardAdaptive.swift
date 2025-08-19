//
//  KeyboardAdaptive.swift
//  Mood
//
//  Created by Damilare on 04/06/2025.
//

import SwiftUI
import Combine
import UIKit

struct KeyboardAdaptive: ViewModifier {
    @State private var keyboardHeight: CGFloat = 0
    
    func body(content: Content) -> some View {
        content
            .padding(.bottom, keyboardHeight)
            .animation(.easeOut(duration: 0.25), value: keyboardHeight)
            .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillChangeFrameNotification)) { notification in
                guard let info = notification.userInfo,
                      let endFrame = info[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
                    return
                }
                let screenHeight = UIScreen.main.bounds.height
                let height = max(0, screenHeight - endFrame.origin.y)
                keyboardHeight = height
            }
            .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
                keyboardHeight = 0
            }
    }
}

extension View {
    func keyboardAdaptive() -> some View {
        modifier(KeyboardAdaptive())
    }
}
