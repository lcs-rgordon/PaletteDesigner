//
//  SwatchView.swift
//  PaletteDesigner
//
//  Created by Russell Gordon on 2024-09-08.
//

import SwiftUI

struct SwatchView: View {
    
    // MARK: Stored properties
    let color: Color
    @Environment(\.self) var environment
    @State private var resolvedColor: Color.Resolved?
    
    // MARK: Computed properties
    var foregroundColor: Color {
        return .black
    }
    
    var body: some View {
        Rectangle()
            .frame(width: 200, height: 100)
            .foregroundStyle(color)
            .overlay {
                VStack {
                    Text(color.hexRepresentation)
                        .foregroundStyle(Color.white)
                    
                    if let resolvedColor {
                        Grid {
                            GridRow {
                                Text("R:")
                                Text("\(resolvedColor.red)")
                                
                                Text("H:")
                                Text("\(resolvedColor.hsba.hue)")
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
                        .foregroundStyle(Color.white)
                    }
                }
            }
            .onAppear {
                getColor()
            }
    }
    
    func getColor() {
        resolvedColor = color.resolve(in: environment)
    }
}

#Preview {
    SwatchView(color: Color.red)
}
