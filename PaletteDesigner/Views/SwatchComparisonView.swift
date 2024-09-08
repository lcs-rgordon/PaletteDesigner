//
//  SwatchComparisonView.swift
//  PaletteDesigner
//
//  Created by Russell Gordon on 2024-09-08.
//

import SwiftUI

struct SwatchComparisonView: View {
    
    let givenColor: Swatch
    @State private var adjustmentFactor = 0.0
    
    var body: some View {
        HStack {
            SwatchView(swatch: givenColor)
            Stepper(value: $adjustmentFactor,
                step: 0.5,
                format: .number.precision(.fractionLength(1)),
                    label: {
                Text("Adjust hue by:")
            })
            SwatchView(
                swatch: Swatch(
                    colorInHex: givenColor.colorInHex,
                    hueAdjustment: adjustmentFactor
                )
            )
        }
    }
}

#Preview {
    SwatchComparisonView(givenColor: Swatch(colorInHex: "FFA557"))
}
