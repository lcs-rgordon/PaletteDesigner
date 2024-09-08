//
//  SwatchComparisonView.swift
//  PaletteDesigner
//
//  Created by Russell Gordon on 2024-09-08.
//

import SwiftUI

struct SwatchComparisonView: View {
    
    let givenColor: Swatch
    @State private var hueAdjustmentFactor = 0.0
    @State private var saturationAdjustmentFactor = 0.0
    @State private var brightnessAdjustmentFactor = 0.0

    var body: some View {
        HStack {
            SwatchView(swatch: givenColor)
            VStack(alignment: .trailing) {
                Text("Adjustments")
                    .bold()
                Stepper(value: $hueAdjustmentFactor,
                    step: 0.5,
                    format: .number.precision(.fractionLength(1)),
                        label: {
                    Text("Hue")
                })
                Stepper(value: $saturationAdjustmentFactor,
                    step: 0.5,
                    format: .number.precision(.fractionLength(1)),
                        label: {
                    Text("Saturation:")
                })
                Stepper(value: $brightnessAdjustmentFactor,
                    step: 0.5,
                    format: .number.precision(.fractionLength(1)),
                        label: {
                    Text("Brightness:")
                })
            }
            SwatchView(
                swatch: Swatch(
                    colorInHex: givenColor.colorInHex,
                    hueAdjustment: hueAdjustmentFactor,
                    saturationAdjustment: saturationAdjustmentFactor,
                    brightnessAdjustment: brightnessAdjustmentFactor
                )
            )
        }
    }
}

#Preview {
    SwatchComparisonView(givenColor: Swatch(colorInHex: "284b63"))
}
