//
//  Video3.swift
//  swiftui-loop-videoplayer-example
//
//  Created by Igor Shelopaev on 29.08.24.
//

import SwiftUI
import swiftui_loop_videoplayer

struct Video3 : VideoTpl{
    
    static public let videoPrefix : String = "Video3"
    
    static public var videoPlayerIdentifier : String {
        "\(videoPrefix)_ExtVideoPlayer"
    }
    
    static public var errorWidgetIdentifier : String {
        "\(videoPrefix)_ErrorWidget"
    }
    
    static public let sourceName = "swipe_"
    
    @State private var error : VPErrors? = nil
    
    private var getOffsetY : CGFloat{
        error == nil ? -1002 : 0
    }
    
    var body: some View{
        ZStack(alignment: .center) {
            ExtVideoPlayer{
                VideoSettings{
                    SourceName(Video3.sourceName)
                    Loop()
                    Events([.all])
                }
            }
            .accessibilityIdentifier(Video3.videoPlayerIdentifier)
            .onPlayerEventChange { events in
                print(events)
                events.forEach { item in
                    if case .error(let e) = item {
                        withAnimation(.spring){
                            error = e
                        }
                    }
                }
            }
            errorTpl
        }.background(Color("app_blue"))
    }
    
    @ViewBuilder
    private var errorTpl : some View{
        Text("\(error?.description ?? "")")
            .padding()
            .background(Color.orange)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(50)
            .font(.largeTitle)
            .offset(y: getOffsetY )
            .accessibilityIdentifier(Video3.errorWidgetIdentifier)
    }
}
