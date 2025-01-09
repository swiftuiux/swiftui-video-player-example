//
//  PlayButton.swift
//  swiftui-loop-videoplayer-example
//
//  Created by Igor Shelopaev on 12.09.24.
//

import SwiftUI
import swiftui_loop_videoplayer

struct PlayButton: View {
    
    @Binding public var playbackCommand: PlaybackCommand
    
    @State private var isPlaying: Bool = true
    
    var body: some View {
        // Button to play the video
        if !isPlaying{
            makeButton(action: {
                play()
                isPlaying = true
            }, imageName: "play.fill", backgroundColor: .ultraThin)
        }else{
            // Button to pause the video
            makeButton(action: {
                pause()
                isPlaying = false
            }, imageName: "pause.fill", backgroundColor: .ultraThin)
        }
    }
    
    private func pause() {
        playbackCommand = .pause
    }
    
    private func play() {
        playbackCommand = .play
    }
}
