//
//  UIImageExtensions.swift
//  Cards
//
//  Created by CPW Front Office iMac on 9/21/25.
//

import SwiftUI

extension UIImage {
  static let minsize = CGSize(width: 300, height: 200)
  static let maxSize = CGSize(width: 1000, height: 1500)

  func save(to filename: String? = nil) -> String {
    let image = resizeLargeImage()
    let path = filename ?? UUID().uuidString
    let url = URL.documentsDirectory.appendingPathComponent(path)
    do {
      try image.pngData()?.write(to: url.appendingPathExtension(for: .png)
      )
    } catch {
      print(error.localizedDescription)
    }
    return url.lastPathComponent
  }

  static func load(uuidString: String) -> UIImage {
    guard uuidString != "none" else { return .error }
    let url = URL.documentsDirectory.appendingPathComponent(uuidString)
      .appendingPathExtension(for: .png)
    if let imageData = try? Data(contentsOf: url) {
      return UIImage(data: imageData) ?? .error
    } else {
      return .error
    }
  }

  static func remove(name: String?) {
    if let name {
      let url = URL.documentsDirectory.appendingPathComponent(name)
        .appendingPathExtension(for: .png)
      try? FileManager.default.removeItem(at: url)
    }
  }
}

extension UIImage {
  func initialSize() -> CGSize {
    var width = Settings.defaultElementSize.width
    var height = Settings.defaultElementSize.height

    if self.size.width >= self.size.height {
      width = max(Self.minsize.width, width)
      width = min(Self.maxSize.width, width)
      height = self.size.height * (width / self.size.width)
    } else {
      height = max(Self.minsize.height, height)
      height = min(Self.maxSize.height, height)
      width = self.size.width * (height / self.size.height)
    }
    return CGSize(width: width, height: height)
  }

  static func imageSize(named imageName: String) -> CGSize {
    if let image = UIImage(named: imageName) {
      return image.initialSize()
    }
    return .zero
  }
}

extension UIImage {
  func resizeLargeImage() -> UIImage {
    let defaultSize: CGFloat = 1000
    if size.width <= defaultSize ||
      size.height <= defaultSize { return self }

    let scale: CGFloat
    if size.width >= size.height {
      scale = defaultSize / size.width
    } else {
      scale = defaultSize / size.height
    }
    let newSize = CGSize(
      width: size.width * scale,
      height: size.height * scale)
    return resize(to: newSize)
  }

  func resize(to size: CGSize) -> UIImage {
    let format = UIGraphicsImageRendererFormat()
    format.scale = 1
    return UIGraphicsImageRenderer(size: size, format: format).image { _ in
      draw(in: CGRect(origin: .zero, size: size))
    }
  }
}

extension UIImage {
  @MainActor static func screenshot(card: Card, size: CGSize) -> UIImage {
    let cardView = ShareCardView(card: card)
    let content = cardView.content(size: size)
    let renderer = ImageRenderer(content: content)
    return renderer.uiImage ?? UIImage.error
  }
}
