//
//  ColorResolved.swift
//  PaletteDesigner
//
//  Created by Russell Gordon on 2024-09-08.
//

import SwiftUI

// NOTE
// Formula to convert from RGB to HSB obtained here:
// https://www.30secondsofcode.org/js/s/rgb-hex-hsl-hsb-color-format-conversion/
//
// ChatGPT used to convert Javascript function to a Swift function.
// Some modifications were then made to make this a computed property that includes an alpha (opacity) value.
//

extension Color.Resolved {
    
    var hsba: (hue: Double, saturation: Double, brightness: Double, alpha: Double) {
        // Obtain RGB values
        let red = Double(self.red)
        let green = Double(self.green)
        let blue = Double(self.blue)
        let alpha = Double(self.opacity * 100.0)
        
        // Find the maximum and minimum of the normalized RGB values
        let maxValue = max(red, green, blue)
        let minValue = min(red, green, blue)
        let delta = maxValue - minValue
        
        // Calculate brightness (value)
        let brightness = maxValue * 100.0
        
        // Calculate hue
        var hue: Double = 0
        if delta != 0 {
            if maxValue == red {
                hue = (green - blue) / delta
            } else if maxValue == green {
                hue = 2.0 + (blue - red) / delta
            } else if maxValue == blue {
                hue = 4.0 + (red - green) / delta
            }
            
            hue *= 60.0
            if hue < 0 {
                hue += 360.0
            }
        }
        
        // Calculate saturation
        let saturation = (maxValue == 0) ? 0 : (delta / maxValue) * 100.0
        
        return (hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
    }
    
}

extension Color.Resolved {

    var shortHex: String {
        return String(self.description.dropLast(2))
    }

}
