//
//  Video8ViewModel.swift
//  swiftui-loop-videoplayer-example
//
//  Created by Igor Shelopaev on 12.09.24.
//

import SwiftUI
import AVFoundation

final class Video8ViewModel : ObservableObject{
    
    @Published private(set) var duration: Double = 0
    
    @Published var currentTime: Double = 0
    
    var isNotReady : Bool{
        duration == 0
    }
    
    public func getDuration(from url: String) {
        
        guard let videoURL = URL(string: url) else { return }
        
        duration = 0
        currentTime = 0
        
        Task {
        
            let asset = AVAsset(url: videoURL)

            if let duration = try? await asset.load(.duration){
                await MainActor.run{
                    self.duration = duration.seconds
                }
            }
        }
    }
}
