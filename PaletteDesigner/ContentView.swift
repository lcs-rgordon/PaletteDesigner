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
    @State private var providedColorInHex: String = "AFAFAF"
    @State private var providedColors: [Color] = []

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
                
                Rectangle()
                    .frame(width: 200, height: 100)
                    .foregroundStyle(providedColor)
                
                Button {
                    providedColors.append(providedColor)
                } label: {
                    Text("Add")
                }
                
                VStack(spacing: 0) {
                    ForEach(providedColors, id: \.self) { currentColor in
                        Rectangle()
                            .frame(width: 200, height: 100)
                            .foregroundStyle(currentColor)
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
