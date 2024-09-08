//
//  SwatchView.swift
//  PaletteDesigner
//
//  Created by Russell Gordon on 2024-09-08.
//

import SwiftUI

struct SwatchView: View {
    
    let color: Color
    
    var body: some View {
        Rectangle()
            .frame(width: 200, height: 100)
            .foregroundStyle(color)
    }
}

#Preview {
    SwatchView(color: Color.red)
}
