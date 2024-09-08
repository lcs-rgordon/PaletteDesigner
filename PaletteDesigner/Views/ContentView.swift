//
//  ContentView.swift
//  PaletteDesigner
//
//  Created by Russell Gordon on 2024-09-08.
//

import NVMColor
import SwiftUI

struct ContentView: View {
    
    // MARK: Stored properties
    @State private var providedColorInHex: String = ""
    @State private var providedColors: [Swatch] = []

    // MARK: Computed properties
    var providedColor: Color {
        guard let providedColor = Color(hex: providedColorInHex) else {
            return .black
        }
        return providedColor
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                
                TextField("Type a color in hexadecimal:", text: $providedColorInHex)
                
                SwatchView(
                    swatch: Swatch(
                        colorInHex: providedColorInHex
                    )
                )
                
                Button {
                    let newSwatch = Swatch(colorInHex: providedColorInHex)
                    providedColors.append(newSwatch)
                } label: {
                    Text("Add")
                }
                
                VStack(spacing: 0) {
                    ForEach(providedColors, id: \.self) { currentColor in
                        SwatchComparisonView(givenColor: currentColor)
                    }
                }
                
                Spacer()
            }
            .padding()
            .background {
                Color.white
            }

        }
    }
}

#Preview {
    ContentView()
}
