//
//  TimeSlider.swift
//  swiftui-loop-videoplayer-example
//
//  Created by Igor Shelopaev on 12.09.24.
//

import SwiftUI
import swiftui_loop_videoplayer

struct TimeSlider: View {
    
    let duration : Double
    
    @Binding public var playbackCommand: PlaybackCommand
    
    @Binding var currentTime : Double
    
    @Binding var isSeeking : Bool
    
    var body: some View {
        sliderTpl
    }
    
    @ViewBuilder
    private var sliderTpl: some View{
        HStack {
            let max = duration > 0 ? duration : 0
                Text(formatTime(currentTime))
                    .padding(.leading, 15)
                Slider(value: $currentTime, in: 0...max, onEditingChanged: onEditingChanged)
                    .disabled(duration == 0 || isSeeking == true)
                Text(formatTime(duration))
                    .padding(.trailing, 15)
        }.padding(5)
         .background(RoundedRectangle(cornerRadius: 50).fill(.gray.opacity(0.75)))
         .padding(.horizontal)
    }
    
    private func onEditingChanged(editing: Bool) {
        if !editing {
            seekToTime(currentTime)
        }else{
            isSeeking = true
        }
    }
    
    private func seekToTime(_ time: Double) {
        let command: PlaybackCommand  = .seek(to: time)
        
        if playbackCommand != command{
            playbackCommand = command
        }else{
            isSeeking = false
        }
    }
}

fileprivate func formatTime(_ time: Double) -> String {
    guard !time.isNaN else { return "0:00" } // Return a default value if time is NaN
    
    let minutes = Int(time) / 60
    let seconds = Int(time) % 60
    return String(format: "%d:%02d", minutes, seconds)
}
