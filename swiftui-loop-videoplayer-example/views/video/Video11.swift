//
//  Video.swift
//  swiftui-loop-videoplayer-example
//
//  Created by Igor Shelopaev on 29.08.24.
//

import SwiftUI
import swiftui_loop_videoplayer

struct Video11 : VideoTpl{
    
    @State public var playbackCommand: PlaybackCommand = .idle
    
    static public let videoPrefix : String = "Video11"
    
    static public var videoPlayerIdentifier : String {
        "\(videoPrefix)_ExtVideoPlayer"
    }
    
    static public var loopCounterIdentifier : String {
        "\(videoPrefix)_LoopCounter"
    }
    
    let fileName : String = "swipe"
    
    @State var loopCount : Int = 1
    
    var body: some View{
            ZStack{
                ExtVideoPlayer(settings: .constant(getSettings()), command: $playbackCommand)
                .onPlayerEventChange { events in
                    print(events)
                    let count = events.filter {
                        if case .currentItemChanged(_) = $0 {
                            return true
                        } else {
                            return false
                        }
                    }.count
                    loopCount += count
                }
                .accessibilityIdentifier(Video11.videoPlayerIdentifier)
                .task{
                      try? await Task.sleep(for: .seconds(0.5))
                      playbackCommand = .play
                }
                Text("Loop count \(loopCount)")
                    .padding()
                    .background(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .accessibilityIdentifier(Video11.loopCounterIdentifier)
            }.ignoresSafeArea()
            .background(Color("app_blue"))
    }
}

// MARK: - Fileprivate

fileprivate func getSettings() -> VideoSettings{
    VideoSettings{
        SourceName("swipe")
        Ext("mp4")
        Gravity(.resizeAspectFill)
        Loop()
        NotAutoPlay()
    }
}
