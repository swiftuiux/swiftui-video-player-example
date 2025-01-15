//
//  FiltersView.swift
//  swiftui-loop-videoplayer-example
//
//  Created by Igor Shelopaev on 12.09.24.
//

import swiftui_loop_videoplayer
import SwiftUI

struct FiltersPicker: View {
    
    @Binding public var playbackCommand: PlaybackCommand
    
    @State private var selectedFilterIndex: Int = 0
    
    var body: some View {
        pickerTpl
    }
    
    @ViewBuilder
    private var pickerTpl : some View {
        HStack {
            Text("Select Filter")
                .fixedSize(horizontal: true, vertical: false)
                .lineLimit(1)
            Spacer()
            Picker("Select Filter", selection: $selectedFilterIndex) {
                ForEach(0..<filters.count, id: \.self) { index in
                    Text(filters[index].0).tag(index)
                }
            }
            .pickerStyle(.menu)
        }
        .onChange(of: selectedFilterIndex) { newIndex in
            applySelectedFilter(index: newIndex)
        }
    }
    
    private func applySelectedFilter(index: Int) {
        let filter = filters[index]

        if filter.0 == "None" {
            playbackCommand = .removeAllFilters
        } else if let filter = CIFilter(name: filter.0, parameters: filter.1) {
            playbackCommand = .filter(filter, clear: true)
        } else {
            let filter = ArtFilter()
            playbackCommand = .filter(filter, clear: true)
        }
    }
}

// MARK: - Fileprivate

// Define the filters with their names and parameters
fileprivate let filters = [
    ("None", [String: Any]()),
    ("Glow", [String: Any]()),
    ("CISepiaTone", [kCIInputIntensityKey: 0.8]),
    ("CIColorMonochrome", [kCIInputColorKey: CIColor(color: .gray), kCIInputIntensityKey: 1.0]),
    ("CIPixellate", [kCIInputScaleKey: 8.0]),
    ("CICrystallize", [kCIInputRadiusKey: 20, kCIInputCenterKey: CIVector(x: 150, y: 150)]),
    ("CIGloom", [kCIInputRadiusKey: 10, kCIInputIntensityKey: 0.75]),
    ("CIKaleidoscope", ["inputCount": 6, "inputCenter": CIVector(x: 150, y: 150)]),
    ("CIZoomBlur", [kCIInputAmountKey: 20, kCIInputCenterKey: CIVector(x: 150, y: 150)])
]
