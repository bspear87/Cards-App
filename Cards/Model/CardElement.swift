//
//  CardElement.swift
//  Cards
//
//  Created by CPW Front Office iMac on 9/14/25.
//

import SwiftUI

protocol CardElement {
  var id: UUID { get }
  var transform: Transform { get set }
}

extension CardElement {
  func index(in array: [CardElement]) -> Int? {
    array.firstIndex { $0.id == id }
  }
}

struct ImageElement: CardElement {
  let id = UUID()
  var transform = Transform()
  var frameIndex: Int?
  var image: Image {
    Image(uiImage: uiImage ?? UIImage.error)
  }
  var uiImage: UIImage?
  var imageFilename: String?
}

extension ImageElement: Codable {
  enum CodingKeys: CodingKey {
    case transform, imageFilename, frameIndex
  }

  init(from decoder: Decoder) throws {
    let container = try decoder
      .container(keyedBy: CodingKeys.self)
    transform = try container
      .decode(Transform.self, forKey: .transform)
    frameIndex = try container
      .decodeIfPresent(Int.self, forKey: .frameIndex)
    imageFilename = try container.decodeIfPresent(
      String.self,
      forKey: .imageFilename)
    if let imageFilename {
      uiImage = UIImage.load(uuidString: imageFilename)
    } else {
      uiImage = UIImage.error
    }
  }

  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(transform, forKey: .transform)
    try container.encode(frameIndex, forKey: .frameIndex)
    try container.encode(imageFilename, forKey: .imageFilename)
  }
}

struct TextElement: CardElement {
  let id = UUID()
  var transform = Transform()
  var text = ""
  var textColor = Color.black
  var textFont = "Gill Sans"
}

extension TextElement: Codable {
  enum CodingKeys: CodingKey {
    case transform, text, textColor, textFont
  }

  init(from decoder: Decoder) throws {
    let container = try decoder
      .container(keyedBy: CodingKeys.self)
    transform = try container
      .decode(Transform.self, forKey: .transform)
    text = try container
      .decode(String.self, forKey: .text)
    let resolvedColor = try container.decode(
      Color.Resolved.self,
      forKey: .textColor)
    textColor = Color(resolvedColor)
    textFont = try container
      .decode(String.self, forKey: .textFont)
  }

  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(transform, forKey: .transform)
    try container.encode(text, forKey: .text)
    let resolvedColor = textColor.resolve(in: EnvironmentValues())
    try container.encode(resolvedColor, forKey: .textColor)
    try container.encode(textFont, forKey: .textFont)
  }
}
