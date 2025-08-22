//
//  Untitled.swift
//  swiftui-loop-videoplayer-example
//
//  Created by Igor  on 21.08.25.
//


#include <metal_stdlib>
#include <CoreImage/CoreImage.h>
using namespace metal;

extern "C" { namespace coreimage {

// Line ripple across the whole image; t = time (seconds)
float4 artEffect(sampler src, float t, destination dest) {
    float2 d  = dest.coord();                 // output pixel coordinate
    float2 uv = samplerTransform(src, d);     // map to source coordinate
    float2 sz = samplerSize(src);             // source image size (pixels)

    // Stable parameters (tweak as needed)
    const float a      = 0.001;               // ripple amplitude in pixels
    const float lambda = 48.0;                // wavelength in pixels
    const float k      = 6.28318530718 / lambda; // spatial frequency (2π/λ)
    const float w      = 1.0;                 // angular speed (rad/s)

    // Vertical offset driven by horizontal phase
    float yOff = a * sin(d.x * k - w * t);    // vertical displacement (px)

    // Sample the source at displaced coordinate (clamped to bounds)
    float2 uv2 = float2(uv.x, clamp(uv.y + yOff, 0.0, sz.y - 1.0));

    return src.sample(uv2);                   // return rippled image
}

} } // extern "C" / namespace coreimage
