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

// Hope all the links work! :)
fileprivate let videoOptions = [
    "HLS Apple Stream from URL": "https://devstreaming-cdn.apple.com/videos/streaming/examples/img_bipbop_adv_example_ts/master.m3u8",
    "Big Buck Bunny from URL": "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
    "Elephant's Dream from URL": "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
    "Sintel" : "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8",
    "Becoming You (Dolby Vision & Atmos)" : "https://devstreaming-cdn.apple.com/videos/streaming/examples/adv_dv_atmos/main.m3u8"
]

extension VideoURLPicker{
    
    static let embeddedSubtitledVideo = "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8"
    
    static let subtitlesFromFileVideo = "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4"
    
    static let initVideo = "https://devstreaming-cdn.apple.com/videos/streaming/examples/adv_dv_atmos/main.m3u8"
}
