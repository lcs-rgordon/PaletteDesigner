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
    
    var body: some View {
        
        if let providedColor = providedColor {
            
            Rectangle()
                .frame(width: 200, height: 100)
                .foregroundStyle(providedColor)
                .hueRotation(.degrees(swatch.hueAdjustment ?? 0.0))
                .overlay {
                    VStack {
                        
                        if let resolvedColor {
                            Grid {
                                GridRow {
                                    Text(resolvedColor.shortHex)
                                        .gridCellColumns(4)
                                }
                                
                                GridRow {
                                    Text("R:")
                                    Text("\(resolvedColor.red)")
                                    
                                    Text("H:")
                                    Text("\(swatch.hueAdjustment == nil ? resolvedColor.hsba.hue : resolvedColor.hsba.hue + swatch.hueAdjustment!)")
                                }
                                GridRow {
                                    Text("G:")
                                    Text("\(resolvedColor.green)")

                                    Text("S:")
                                    Text("\(resolvedColor.hsba.saturation)")
                                }
                                GridRow {
                                    Text("B:")
                                    Text("\(resolvedColor.blue)")

                                    Text("B:")
                                    Text("\(resolvedColor.hsba.brightness)")
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
                }
                .onAppear {
                    getColor()
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
    
    func getColor() {
        if let providedColor = providedColor {
            resolvedColor = providedColor.resolve(in: environment)
        }
    }
}

#Preview {
    VStack {
        SwatchView(swatch: Swatch(colorInHex: "000000"))
        SwatchView(swatch: Swatch(colorInHex: "FF"))
    }
}

