#!/usr/bin/env bash
set -euo pipefail

SHADER="Shaders/ArtFilter.metal"
OUTDIR="Resources"
mkdir -p "$OUTDIR"

# 1) iOS device
xcrun -sdk iphoneos metal -c -fcikernel "$SHADER" -o "$OUTDIR/ArtFilter.ios.air"
xcrun -sdk iphoneos metallib -cikernel "$OUTDIR/ArtFilter.ios.air" -o "$OUTDIR/default.ios.metallib"
rm -f "$OUTDIR/ArtFilter.ios.air"

# 2) iOS Simulator
xcrun -sdk iphonesimulator metal -c -fcikernel "$SHADER" -o "$OUTDIR/ArtFilter.sim.air"
xcrun -sdk iphonesimulator metallib -cikernel "$OUTDIR/ArtFilter.sim.air" -o "$OUTDIR/default.sim.metallib"
rm -f "$OUTDIR/ArtFilter.sim.air"


# Check Metal version and that you have it before compile: xcrun metal -v
# Run: ./build_shaders.sh
# Make this build script executable: chmod +x build_shaders.sh

