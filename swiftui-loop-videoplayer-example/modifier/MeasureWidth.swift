//
//  MeasureWidth.swift
//  swiftui-loop-videoplayer-example
//
//  Created by Igor Shelopaev on 13.09.24.
//

import SwiftUI

struct MeasureWidth: ViewModifier {
    @Binding var width: CGFloat

    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { geometry in
                    Color.clear
                        .onAppear {
                            width = geometry.size.width
                        }
                }
            )
    }
}

extension View {
    func measureWidth(_ width: Binding<CGFloat>) -> some View {
        self.modifier(MeasureWidth(width: width))
    }
}
