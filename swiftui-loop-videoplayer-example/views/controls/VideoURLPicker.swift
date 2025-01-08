//
//  VideoURLPicker.swift
//  swiftui-loop-videoplayer-example
//
//  Created by Igor Shelopaev on 12.09.24.
//

import SwiftUI


struct VideoURLPicker: View {
    
    @Binding var selectedVideoURL: String
    
    var body: some View {
        pickerContent
    }
    
    @ViewBuilder
    private var pickerContent: some View {
        Picker("Select Video", selection: $selectedVideoURL) {
            ForEach(videoOptions.keys.sorted(), id: \.self) { key in
                Text(key).tag(videoOptions[key]!)
            }
        }
        .pickerStyle(MenuPickerStyle())
    }
}


fileprivate let videoOptions = [
    "Apple HLS Stream from URL": "https://devstreaming-cdn.apple.com/videos/streaming/examples/img_bipbop_adv_example_ts/master.m3u8",
    "Big Buck Bunny from URL": "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
    "Elephant's Dream from URL": "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4"
]

extension VideoURLPicker{
    
    static let subtitledVideo = "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4"
    
    static let initVideo = "https://devstreaming-cdn.apple.com/videos/streaming/examples/img_bipbop_adv_example_ts/master.m3u8"
}
