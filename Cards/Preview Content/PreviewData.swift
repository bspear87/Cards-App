//
//  PreviewData.swift
//  Cards
//
//  Created by CPW Front Office iMac on 9/14/25.
//

import SwiftUI

var initialCards: [Card] { [
  Card(backgroundColor: .random1, elements: initialElements),
  Card(backgroundColor: .random2),
  Card(backgroundColor: .random3),
  Card(backgroundColor: .random4),
  Card(backgroundColor: .random5),
  Card(backgroundColor: .random6),
  Card(backgroundColor: .random7),
  Card(backgroundColor: .random8)
] }

var initialElements: [CardElement] { [
  ImageElement(
    transform: Transform(
      size: CGSize(width: 750, height: 540),
      offset: CGSize(width: -150, height: -600)),
    uiImage: UIImage(named: "giraffe3")),
  ImageElement(
    transform: Transform(
      size: CGSize(width: 950, height: 675),
      offset: CGSize(width: -300, height: 425)),
    uiImage: UIImage(named: "giraffe2")),
  ImageElement(
    transform: Transform(
      size: CGSize(width: 625, height: 450),
      offset: CGSize(width: 300, height: 405)),
    uiImage: UIImage(named: "giraffe1")),
  TextElement(
    transform: Transform(
      size: Settings.defaultElementSize * 1.1,
      offset: CGSize(width: 0, height: -175)),
    text: "Giraffes!!!",
    textColor: .black)
] }
