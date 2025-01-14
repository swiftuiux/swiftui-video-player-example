//
//  ResponsiveStack.swift
//  swiftui-loop-videoplayer-example
//
//  Created by Igor Shelopaev on 29.08.24.
//

import SwiftUI

struct ResponsiveStack<Content: View>: View {
    let spacing: CGFloat
    @ViewBuilder let content: Content
    
    var body: some View {
        GeometryReader { geometry in
            contentForSize(geometry.size)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    @ViewBuilder
    private func contentForSize(_ size: CGSize) -> some View {
        if size.width > size.height {
            // Landscape mode
            HStack(alignment: .center, spacing: spacing) {
                Spacer()
                content
                Spacer()
            }.frame(width: size.width, height: size.height)
        } else {
            // Portrait mode
            VStack(alignment: .center, spacing: spacing) {
                Spacer()
                content
                Spacer()
            }
            .frame(width: size.width, height: size.height)
        }

    }
}
