//
//  ColorExtensions.swift
//  Cards
//
//  Created by CPW Front Office iMac on 9/14/25.
//

import Foundation
import SwiftUI

extension Color {
    static let colors: [Color] = [
        .green, .red, .blue, .gray, .yellow, .pink, .orange, .purple
    ]
    
    static func random() -> Color {
        colors.randomElement() ?? .black
    }
}
