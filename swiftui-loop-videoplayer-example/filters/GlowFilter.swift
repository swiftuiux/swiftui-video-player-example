//
//  GlowFilter.swift
//  swiftui-loop-videoplayer-example
//
//  Created by Igor  on 22.08.25.
//

import Foundation
import CoreImage

class GlowFilter: CIFilter {
    @objc dynamic var inputImage: CIImage?
    private var edgeDetectionFilter: CIFilter
    private var bloomFilter: CIFilter
    private var hueAdjustFilter: CIFilter

    // Initialize the filters
    override init() {
        edgeDetectionFilter = CIFilter(name: "CIEdges")!
        edgeDetectionFilter.setValue(3.0, forKey: "inputIntensity")

        bloomFilter = CIFilter(name: "CIBloom")!
        bloomFilter.setValue(10.0, forKey: "inputRadius")
        bloomFilter.setValue(1.0, forKey: "inputIntensity")

        hueAdjustFilter = CIFilter(name: "CIHueAdjust")!
        hueAdjustFilter.setValue(2.0 * .pi, forKey: "inputAngle")

        super.init()
    }

    required init?(coder: NSCoder) {
        edgeDetectionFilter = CIFilter(name: "CIEdges")!
        bloomFilter = CIFilter(name: "CIBloom")!
        hueAdjustFilter = CIFilter(name: "CIHueAdjust")!
        super.init(coder: coder)
    }

    override var outputImage: CIImage? {
        guard let inputImage = inputImage else { return nil }

        // Apply edge detection
        edgeDetectionFilter.setValue(inputImage, forKey: kCIInputImageKey)
        guard let edgedImage = edgeDetectionFilter.outputImage else {
            print("Failed to generate edged image.")
            return nil
        }

        // Apply bloom filter
        bloomFilter.setValue(edgedImage, forKey: kCIInputImageKey)
        guard let bloomedImage = bloomFilter.outputImage else {
            print("Failed to generate bloomed image.")
            return nil
        }

        // Adjust hue
        hueAdjustFilter.setValue(bloomedImage, forKey: kCIInputImageKey)
        guard let finalImage = hueAdjustFilter.outputImage else {
            print("Failed to adjust hue on image.")
            return nil
        }

        return finalImage
    }
}
