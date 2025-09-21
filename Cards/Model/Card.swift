//
//  Card.swift
//  Cards
//
//  Created by CPW Front Office iMac on 9/14/25.
//

import SwiftUI

struct Card: Identifiable {
  var id = UUID()
  var backgroundColor: Color = .yellow
  var elements: [CardElement] = []
  var uiImage: UIImage?

  mutating func addElement(
    uiImage: UIImage,
    at offset: CGSize = .zero) {
    let imageFilename = uiImage.save()
    let transform = Transform(offset: offset)
    let element = ImageElement(
      transform: transform,
      uiImage: uiImage,
      imageFilename: imageFilename)
    elements.append(element)
    save()
  }

  mutating func addElement(text: TextElement) {
    elements.append(text)
  }

  mutating func addElements(
    from transfer: [CustomTransfer],
    at offset: CGSize = .zero) {
    for element in transfer {
      if let text = element.text {
        let transform = Transform(offset: offset)
        addElement(
          text: TextElement(
            transform: transform,
            text: text))
      } else if let image = element.image {
        addElement(uiImage: image, at: offset)
      }
    }
  }

  mutating func remove(_ element: CardElement) {
    if let element = element as? ImageElement {
      UIImage.remove(name: element.imageFilename)
    }
    if let index = element.index(in: elements) {
      elements.remove(at: index)
    }
    save()
  }

  mutating func update(_ element: CardElement?, frameIndex: Int) {
    guard element is ImageElement,
          let index = element?.index(in: elements),
          var imageElement = elements[index] as? ImageElement
      else { return }
    imageElement.frameIndex = frameIndex
    elements[index] = imageElement
  }

  func save() {
    do {
      let encoder = JSONEncoder()
      encoder.outputFormatting = .prettyPrinted
      let data = try encoder.encode(self)
      let filename = "\(id).card"
      let url = URL.documentsDirectory
        .appendingPathComponent(filename)
      try data.write(to: url)
    } catch {
      print(error.localizedDescription)
    }
  }
}

extension Card: Codable {
  enum CodingKeys: CodingKey {
    case id, backgroundColor, imageElements, textElements
  }

  init(from decoder: Decoder) throws {
    let container = try decoder
      .container(keyedBy: CodingKeys.self)
    let id = try container.decode(String.self, forKey: .id)
    self.id = UUID(uuidString: id) ?? UUID()
    let resolvedColor = try container.decode(
      Color.Resolved.self,
      forKey: .backgroundColor)
    backgroundColor = Color(resolvedColor)

    elements += try container
      .decode([ImageElement].self, forKey: .imageElements)
    elements += try container
      .decode([TextElement].self, forKey: .textElements)
  }

  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(id.uuidString, forKey: .id)
    let environment = EnvironmentValues()
    let resolvedColor = backgroundColor.resolve(
      in: environment)
    try container.encode(
      resolvedColor,
      forKey: .backgroundColor)
    let imageElements: [ImageElement] =
      elements.compactMap { $0 as? ImageElement }
    try container.encode(imageElements, forKey: .imageElements)
    let textElements: [TextElement] =
      elements.compactMap { $0 as? TextElement }
    try container.encode(textElements, forKey: .textElements)
  }
}
