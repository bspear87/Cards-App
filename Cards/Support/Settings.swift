//
//  Settings.swift
//  Cards
//
//  Created by CPW Front Office iMac on 9/14/25.
//

import Foundation
import SwiftUI

enum Settings {
  static let cardSize =
    CGSize(width: 1300, height: 2000)
  static let thumbnailSize =
    CGSize(width: 150, height: 250)
  static let defaultElementSize =
    CGSize(width: 800, height: 800)
  static let borderColor: Color = .blue
  static let borderWidth: CGFloat = 5

  static func calculateSize(_ size: CGSize) -> CGSize {
    var newSize = size
    let ratio =
      Settings.cardSize.width / Settings.cardSize.height

    if size.width < size.height {
      newSize.height = min(size.height, newSize.width / ratio)
      newSize.width = min(size.width, newSize.height * ratio)
    } else {
      newSize.width = min(size.width, newSize.height * ratio)
      newSize.height = min(size.height, newSize.width / ratio)
    }
    return newSize
  }

  static func calculateScale(_ size: CGSize) -> CGFloat {
    let newSize = calculateSize(size)
    return newSize.width / Settings.cardSize.width
  }
}
extension Settings {
  static func calculateDropOffset(
    viewScale: CGFloat,
    location: CGPoint
  ) -> CGSize {
    let originalX = location.x / viewScale
    let originalY = location.y / viewScale
    let offset = CGSize(
      width: originalX - (Settings.cardSize.width * 0.5),
      height: originalY - (Settings.cardSize.height * 0.5)
    )
    return offset
  }
}
