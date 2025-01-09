//
//  ResponsiveStack.swift
//  swiftui-loop-videoplayer-example
//
//  Created by Igor Shelopaev on 29.08.24.
//

import SwiftUI

struct ResponsiveStack<Content: View>: View {
    
    let spacing : CGFloat
    
    @ViewBuilder let content: Content
    
    var body: some View {
        GeometryReader { geometry in
            if geometry.size.width > geometry.size.height {
                // Landscape mode
                HStack(alignment: .center, spacing: spacing) {
                    Spacer()
                    content
                    Spacer()
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
            } else {
                // Portrait mode
                VStack(alignment: .center, spacing: spacing) {
                    Spacer()
                    content
                    Spacer()
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
