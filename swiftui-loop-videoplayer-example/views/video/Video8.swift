//
//  Video8.swift
//  loop_player
//
//  Created by Igor Shelopaev on 15.08.24.
//

import swiftui_loop_videoplayer
import SwiftUI
import AVFoundation

struct Video8: VideoTpl {
    
    @StateObject var viewModel = Video8ViewModel()
    
    // MARK: - Public properties
    
    @State public var playbackCommand: PlaybackCommand = .idle
    
    @State public var settings = getSettings(for: VideoURLPicker.initVideo)
    
    // MARK: - Private properties
    
    @State private var selectedVideoURL = VideoURLPicker.initVideo
    
    @State private var isSeeking = false
    
    // MARK: - Testing
    
    static let videoPrefix : String = "Video8"
    
    static var videoPlayerIdentifier : String { "\(videoPrefix)_ExtVideoPlayer" }
    
    // MARK: - Life circle
    
    var body: some View {
            ZStack {
                ExtVideoPlayer(settings: $settings, command: $playbackCommand)
                    .accessibilityIdentifier(Self.videoPlayerIdentifier)
                    .onPlayerTimeChange(perform: onPlayerTimeChange)
                    .onPlayerEventChange(perform: onPlayerEventChange)
            }
            .onChange(of: viewModel.duration, perform: onDurationChange)
            .ignoresSafeArea()
            .overlay(timeScaleTpl, alignment: .bottom)
            .toolbar { toolbarTpl }
            .onAppear { handleVideoSelectionChange(selectedVideoURL) }
    }
    
    private var timeScaleTpl : some View{
        TimeSlider(
            duration: viewModel.duration,
            playbackCommand: $playbackCommand,
            currentTime: $viewModel.currentTime,
            isSeeking: $isSeeking
        )
    }
    
    private func onPlayerEventChange(events: [PlayerEvent]){
        print(events)
        events.forEach{
            if case .seek(let success, let currentTime) = $0{
                if success{
                    viewModel.currentTime = currentTime
                }
                isSeeking = false
            }
        }
    }
    
    private func onDurationChange(_ duration : Double){
        if duration > 0 {
            playbackCommand = .play
        }
    }
    
    private func onPlayerTimeChange(newTime: Double){
        guard !isSeeking else{ return }
        viewModel.currentTime = newTime
    }
    
    private func handleVideoSelectionChange(_ newURL: String) {
        playbackCommand = .pause
        viewModel.getDuration(from: newURL)
        settings = getSettings(for: newURL)
    }
    
    @ToolbarContentBuilder
    private var toolbarTpl: some ToolbarContent {
        ToolbarItem(placement: .navigation) {
            VideoURLPicker(selectedVideoURL: $selectedVideoURL)
                .disabled(viewModel.isNotReady)
                .onChange(of: selectedVideoURL) { newURL in
                    let embedded = VideoURLPicker.embeddedSubtitledVideo == newURL
                    // Enable embedded Subtitles
                    playbackCommand = .subtitles(embedded ? "en" : nil)
                  
                    handleVideoSelectionChange(newURL)
                }
        }
    }
}

// MARK: - Fileprivate

fileprivate func getSettings(for name: String) -> VideoSettings{
    VideoSettings {
        Subtitles(name == VideoURLPicker.subtitlesFromFileVideo ? "subtitles_eng" : "")
        SourceName(name)
        Gravity(.resizeAspectFill)
        TimePublishing()
        NotAutoPlay()
        Mute()
    }
}
