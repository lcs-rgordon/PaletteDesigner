//
//  SwatchView.swift
//  PaletteDesigner
//
//  Created by Russell Gordon on 2024-09-08.
//

import SwiftUI

struct SwatchView: View {
    
    // MARK: Stored properties
    let swatch: Swatch
    @Environment(\.self) var environment
    @State private var resolvedColor: Color.Resolved?

    // MARK: Computed properties
    var foregroundColor: Color {
        return .black
    }
    
    var providedColor: Color? {
        return Color(hex: swatch.colorInHex)
    }
    
    var adjustedColorInHex: String? {
        if let resolvedColor = resolvedColor,
           let hueAdjustment = swatch.hueAdjustment,
           let saturationAdjustment = swatch.saturationAdjustment,
           let brightnessAdjustment = swatch.brightnessAdjustment {
            
            let adjustedColor = Color(
                hue: (resolvedColor.hsba.hue + hueAdjustment) / 360.0,
                saturation: (resolvedColor.hsba.saturation + saturationAdjustment) / 100.0,
                brightness: (resolvedColor.hsba.brightness + brightnessAdjustment) / 100.0,
                opacity: resolvedColor.hsba.alpha / 100.0
            )
            
            return adjustedColor.resolve(in: environment).shortHex

        } else {
            return nil
        }
    }
    
    var body: some View {
        
        Group {
            
            let _ = print("Body re-computed")
            
            if let resolvedColor = resolvedColor {
                
                let adjustedColor = Color(
                    hue: (resolvedColor.hsba.hue + (swatch.hueAdjustment ?? 0.0)) / 360.0,
                    saturation: (resolvedColor.hsba.saturation + (swatch.saturationAdjustment ?? 0.0)) / 100.0,
                    brightness: (resolvedColor.hsba.brightness + (swatch.brightnessAdjustment ?? 0.0)) / 100.0,
                    opacity: resolvedColor.hsba.alpha / 100.0
                )
                
                Rectangle()
                    .frame(width: 200, height: 100)
                    .foregroundStyle(adjustedColor)
                    .overlay {
                        VStack {
                            
                            Grid {
                                GridRow {
                                    Text(swatch.hueAdjustment == nil ? resolvedColor.shortHex : adjustedColorInHex ?? "huh?")
                                        .gridCellColumns(4)
                                }
                                
                                GridRow {
                                    Text("R:")
                                    Text("\(resolvedColor.red)")
                                    
                                    Text("H:")
                                    Text("\(adjustedHue(resolvedColor))")
                                }
                                GridRow {
                                    Text("G:")
                                    Text("\(resolvedColor.green)")
                                    
                                    Text("S:")
                                    Text("\(adjustedSaturation(resolvedColor))")
                                    
                                }
                                GridRow {
                                    Text("B:")
                                    Text("\(resolvedColor.blue)")
                                    
                                    Text("B:")
                                    Text("\(adjustedBrightness(resolvedColor))")
                                }
                                GridRow {
                                    Text("A:")
                                    Text("\(resolvedColor.opacity)")
                                    
                                    Text("A:")
                                    Text("\(resolvedColor.hsba.alpha)")
                                }
                            }
                            .foregroundStyle(resolvedColor.hsba.brightness > 50 ? Color.black : Color.white)
                        }
                    }
                
            } else {
                Rectangle()
                    .frame(width: 200, height: 100)
                    .foregroundStyle(Color.white)
                    .border(Color.black, width: 1)
                    .overlay {
                        VStack {
                            Text("Invalid color provided")
                            Text("Provided value was: \(swatch.colorInHex)")
                        }
                    }
            }
        }
        .onAppear {
            getColor()
        }
        .onChange(of: swatch) { old, new in
            getColor()
        }

        
    }
    
    func getColor() {
        if let providedColor = providedColor {
            resolvedColor = providedColor.resolve(in: environment)
        }
    }
    
    func adjustedHue(_ resolvedColor: Color.Resolved) -> Double {
        swatch.hueAdjustment == nil ? resolvedColor.hsba.hue : resolvedColor.hsba.hue + swatch.hueAdjustment!
    }
    
    func adjustedSaturation(_ resolvedColor: Color.Resolved) -> Double {
        swatch.saturationAdjustment == nil ? resolvedColor.hsba.saturation : resolvedColor.hsba.saturation + swatch.saturationAdjustment!
    }
    
    func adjustedBrightness(_ resolvedColor: Color.Resolved) -> Double {
        swatch.brightnessAdjustment == nil ? resolvedColor.hsba.brightness : resolvedColor.hsba.brightness + swatch.brightnessAdjustment!
    }
}

#Preview {
    ContentView()
}

#Preview {
    VStack {
        SwatchView(swatch: Swatch(colorInHex: "284b63", saturationAdjustment: 20.0))
        SwatchView(swatch: Swatch(colorInHex: "FF"))
    }
}

