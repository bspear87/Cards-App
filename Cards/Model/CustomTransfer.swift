//
//  CustomTransfer.swift
//  Cards
//
//  Created by CPW Front Office iMac on 9/21/25.
//

import SwiftUI

struct CustomTransfer: Transferable {
  var image: UIImage?
  var text: String?

  public static var transferRepresentation:
  some TransferRepresentation {
    DataRepresentation(importedContentType: .image) { data in
      let image = UIImage(data: data) ?? UIImage.error
      return CustomTransfer(image: image)
    }
    DataRepresentation(importedContentType: .text) { data in
      let docType = NSAttributedString.DocumentType.html
      let encoding = String.Encoding.utf8.rawValue
      guard let text = try? NSAttributedString(
        data: data,
        options: [
          .documentType: docType,
          .characterEncoding: encoding
        ],
        documentAttributes: nil
      ) else {
        return CustomTransfer(text: nil)
      }
      return CustomTransfer(text: text.string)
    }
  }
}
