//
//  Video6.swift
//  loop_player
//
//  Created by Igor Shelopaev on 09.08.24.
//
import swiftui_loop_videoplayer
import SwiftUI
import AVFoundation
import CoreImage
import Combine

struct Video6: VideoTpl {
    
    // MARK: - Testing
    
    static let videoPrefix : String = "Video6"
    
    static var videoPlayerIdentifier : String {  "\(videoPrefix)_ExtVideoPlayer" }
    
    // MARK: - Public properties
    
    @State public var playbackCommand: PlaybackCommand = .idle
    
    @State public var settings : VideoSettings
    
    @State private var vStackWidth: CGFloat = 0
    
    init(videoName : String){
        let settings = VideoSettings {
            SourceName(videoName)
            Loop()
            Mute()
            EnableVector()
            Gravity(.resizeAspectFill)
        }
        self._settings = State(initialValue: settings)
        
        setupThrottle()
    }
    
    // Combine properties for throttling
    @State private var boundsChangeSubject = PassthroughSubject<CGRect, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Life circle
    
    var body: some View {
            VStack{
                ExtVideoPlayer(
                    settings : $settings,
                    command: $playbackCommand
                )
                .onPlayerEventChange(perform: onPlayerEventChange)
                .frame(minHeight: vStackWidth)
                .accessibilityIdentifier(Self.videoPlayerIdentifier)
                .mask{
                    RoundedRectangle(cornerRadius: 25)
                }
                playbackControlsTpl
                VectorToggle(playbackCommand: $playbackCommand)
                FiltersPicker(playbackCommand: $playbackCommand)
                /// Brightness and Contrast: These settings function also filters but are managed separately from the filter stack. Adjustments to brightness and contrast are applied additionally and independently of the image filters.
                /// Independent Management: Developers should manage brightness and contrast adjustments through their dedicated methods or properties to ensure these settings are accurately reflected in the video output.
                BrightnessSlider(playbackCommand: $playbackCommand)
                ContrastSlider(playbackCommand: $playbackCommand)
            }.padding(.horizontal)
            .measureWidth($vStackWidth) // Using the custom modifier
    }

    @ViewBuilder
    private var playbackControlsTpl: some View{
        // Control Buttons
            HStack {
                Spacer()
                BeginButton(playbackCommand: $playbackCommand)
                PlayButton(playbackCommand: $playbackCommand)
                SeekButton(playbackCommand: $playbackCommand)
                EndButton(playbackCommand: $playbackCommand)
                MuteButton(playbackCommand: $playbackCommand)
                Spacer()
            }
            .padding(.vertical, 8)
            .background(RoundedRectangle(cornerRadius: 50).fill(.ultraThinMaterial))
    }
    
    private func onPlayerEventChange(events: [PlayerEvent]){
        events.forEach {
            if case .boundsChanged(let rect) = $0{
                print(rect, "rect")
                // Send boundsChanged event to the throttle mechanism
                boundsChangeSubject.send(rect)
            }
        }
    }
    
    // MARK: - Throttle Setup
    
    private mutating func setupThrottle() {
        boundsChangeSubject
            .throttle(for: .milliseconds(500), scheduler: DispatchQueue.main, latest: true)
            .sink { rect in
                print(rect)
            }
            .store(in: &cancellables)
    }
}
