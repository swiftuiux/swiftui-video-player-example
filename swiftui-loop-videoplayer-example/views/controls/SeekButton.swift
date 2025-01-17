//
//  SeekButton.swift
//  swiftui-loop-videoplayer-example
//
//  Created by Igor Shelopaev on 12.09.24.
//

import swiftui_loop_videoplayer
import SwiftUI

struct SeekButton : View {
    
    @Binding public var playbackCommand: PlaybackCommand
    
    @State private var isSeeking : Bool = false
    
    var body: some View {
        // Button to seek back 2 seconds in the video and pause
        makeButton(action: {
            seek(to: 2.0)
        }, imageName: "gobackward.10")
        .disabled(isSeeking)
        .onPlayerEventChange(perform: onPlayerEventChange)
        .onChange(of: playbackCommand, perform: updatePlayingState)
    }
    
    private func seek(to value: Double) {
        playbackCommand = .seek(to: value)
    }
    
    private func updatePlayingState(for command: PlaybackCommand) {
        switch command {
        case .seek(_,_):
            isSeeking = true
        default:
            break // No action needed for other commands
        }
    }
    
    private func onPlayerEventChange(events: [PlayerEvent]){
        print(events)
        events.forEach{
            if case .seek(_, _) = $0{
                playbackCommand = .idle
                isSeeking = false
            }
        }
    }
}
