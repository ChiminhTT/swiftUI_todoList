//
//  Theme.swift
//  swift_workshop_1
//
//  Created by Maxence on 9/24/21.
//

import SwiftUI

extension View {
    func styleAsTextfield() -> some View {
        modifier(TextfieldModifier())
    }
}

struct TextfieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .overlay(
                Rectangle().stroke(lineWidth: 1)
            )
            .padding(.top)
    }
}
