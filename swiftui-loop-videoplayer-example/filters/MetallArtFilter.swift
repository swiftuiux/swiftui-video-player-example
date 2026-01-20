///Users/igor/Documents/GitHub/swiftui-loop-videoplayer-example/swiftui-loop-videoplayer-example/build_shaders.sh
//  ArtFilter.swift
//  swiftui-loop-videoplayer-example
//
//  Created by Igor Shelopaev on 13.08.24.
//

import Foundation
import CoreImage
import AVKit

@available(iOS 15.0, *)
final class MetallArtFilter: CIFilter {
    
    @objc dynamic var inputImage: CIImage?

    // MARK: - Kernel loading (metallib from bundle only)
    private static let kernel: CIKernel? = {
        // Prefer simulator/device-specific metallibs if you ship both.
        #if targetEnvironment(simulator)
        let candidates = ["default.sim", "default"]   // default.sim.metallib, default.metallib
        #else
        let candidates = ["default.ios", "default"]   // default.ios.metallib, default.metallib
        #endif

        #if SWIFT_PACKAGE
        let bundle: Bundle = .module
        #else
        let bundle: Bundle = .main
        #endif

        for name in candidates {
            if let url = bundle.url(forResource: name, withExtension: "metallib"),
               let data = try? Data(contentsOf: url),
               let k = try? CIKernel(functionName: "artEffect",
                                     fromMetalLibraryData: data) {
                return k
            }
        }

        return nil
    }()

    @objc dynamic var inputTime: NSNumber?

    private static var t0: CFTimeInterval = 0

    override var outputImage: CIImage? {
        guard let inputImage, let kernel = Self.kernel else { return inputImage }

        let t: Double
        if let v = inputTime?.doubleValue { t = v }
        else {
            let now = CACurrentMediaTime()
            if Self.t0 == 0 { Self.t0 = now }
            t = now - Self.t0
        }

        let extent = inputImage.extent
        return kernel.apply(
            extent: extent,
            roiCallback: { _, _ in extent },
            arguments: [inputImage, NSNumber(value: t)]
        )
    }
}

