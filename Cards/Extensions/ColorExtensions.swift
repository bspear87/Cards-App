//
//  ColorExtensions.swift
//  Cards
//
//  Created by CPW Front Office iMac on 9/14/25.
//

import Foundation
import SwiftUI

extension Color {
  static let Colors: [Color] = [
    .random1,.random2,.random3, .random4,
    .random5,.random6,.random7, .random8
    ]
    
    
    
    
  static func random() -> Color {
    Colors.randomElement() ?? .black
  }
}
