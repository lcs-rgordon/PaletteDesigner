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
                        Text("R: \(resolvedColor.red)")
                            .foregroundStyle(Color.white)
                        Text("G: \(resolvedColor.green)")
                            .foregroundStyle(Color.white)
                        Text("B: \(resolvedColor.blue)")
                            .foregroundStyle(Color.white)
                        Text("O: \(resolvedColor.opacity)")
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
