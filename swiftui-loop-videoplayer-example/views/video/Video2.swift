//
//  Video2.swift
//  swiftui-loop-videoplayer-example
//
//  Created by Igor Shelopaev on 29.08.24.
//

import SwiftUI
import swiftui_loop_videoplayer

struct Video2 : VideoTpl{
    
    static let videoPrefix : String = "Video2"
    
    static var videoPlayerIdentifier : String {  "\(videoPrefix)_ExtVideoPlayer" }
    
    var body: some View{
        ZStack {
            ExtVideoPlayer{
                VideoSettings{
                    SourceName("swipe")
                    Loop()
                }
            }.accessibilityIdentifier(Self.videoPlayerIdentifier)
        }.background(Color("app_blue"))
    }
}
