//
//  Color.swift
//  PaletteDesigner
//
//  Created by Russell Gordon on 2024-09-08.
//

import NVMColor
import SwiftUI

extension Color {
    // Get the hex value
    var hexRepresentation: String {
        return String(self.hex?.isHex()?.dropLast(2) ?? "FFFFFF")
    }

}
