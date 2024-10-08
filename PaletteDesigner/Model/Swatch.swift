//
//  Swatch.swift
//  PaletteDesigner
//
//  Created by Russell Gordon on 2024-09-08.
//

import Foundation

struct Swatch: Identifiable, Hashable {
    let id = UUID()
    let colorInHex: String
    var hueAdjustment: Double? = nil
    var saturationAdjustment: Double? = nil
    var brightnessAdjustment: Double? = nil
}
