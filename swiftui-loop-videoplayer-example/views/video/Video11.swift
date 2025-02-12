//
//  Video.swift
//  swiftui-loop-videoplayer-example
//
//  Created by Igor Shelopaev on 29.08.24.
//

import SwiftUI
import swiftui_loop_videoplayer

struct Video11: VideoTpl {
    // MARK: - State
    
    @State private var playbackCommand: PlaybackCommand = .idle
    @State private var stoppedPiP: Bool = false
    @State private var loopCount: Int = 1

    // MARK: - Static Properties
    
    static let videoPrefix: String = "Video11"
    
    static var videoPlayerIdentifier: String {
        "\(videoPrefix)_ExtVideoPlayer"
    }
    
    static var loopCounterIdentifier: String {
        "\(videoPrefix)_LoopCounter"
    }
    
    // MARK: - Constants
    
    private let fileName: String = "swipe"

    // MARK: - Body
    
    var body: some View {
        ZStack {
            // Main Video Player
            ExtVideoPlayer(settings: .constant(videoSettings),
                           command: $playbackCommand)
                .onPlayerEventChange(perform: handlePlayerEvents)
                .task{ await handlePiPStart(delay: true) }
                .accessibilityIdentifier(Self.videoPlayerIdentifier)
            overlayView
        }
        .ignoresSafeArea()
        .background(Color("app_blue"))
    }
}

// MARK: - Private Helpers
private extension Video11 {
    /// Video player settings wrapped in a computed property for clarity.
    var videoSettings: VideoSettings {
        VideoSettings {
            SourceName(fileName)
            Ext("mp4")
            Gravity(.resizeAspectFill)
            Loop()
            PictureInPicture()
            Events([.all])
        }
    }
    
    /// Asynchronously trigger PiP after a short delay (mimicking your existing logic).
    @Sendable
    func handlePiPStart(delay : Bool = false) async {
            if delay{ try? await Task.sleep(for: .seconds(0.5)) }
        
            playbackCommand = .startPiP
            
            Task{ @MainActor in
                playbackCommand = .idle
                stoppedPiP = false
            }
    }
    
    /// Handles all events from the player.
    func handlePlayerEvents(_ events: [PlayerEvent]) {
        print(events)
        for event in events {
            switch event {
            case .currentItemChanged:
                // Increase loop count whenever the item changes
                loopCount += 1
                
            case .stoppedPiP:
                // Mark that PiP has stopped
                stoppedPiP = true
                
            default:
                break
            }
        }
    }
    
    /// Creates the overlay views on top of the video.
    @ViewBuilder
    var overlayView: some View {
        VStack {
            Text("Loop count \(loopCount)")
                .padding()
                .frame(width: 150)
                .background(Color.blue)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .accessibilityIdentifier(Self.loopCounterIdentifier)
            
            Text("PiP start")
                .padding()
                .frame(width: 150)
                .background(Color.orange)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                // Show this button only when PiP has stopped
                .opacity(stoppedPiP ? 1 : 0)
                .onTapGesture{
                    Task{
                        await handlePiPStart()
                    }
                }
        }
    }
}
