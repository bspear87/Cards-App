//
//  CardThumbnail.swift
//  Cards
//
//  Created by CPW Front Office iMac on 9/14/25.
//

import SwiftUI

struct CardThumbnail: View {
  let card: Card

  var body: some View {
    Group {
      let image = UIImage.load(uuidString: card.id.uuidString)
      if image != .error {
        Image(uiImage: image)
          .resizable()
          .scaledToFill()
      } else {
        card.backgroundColor
      }
    }
    .cornerRadius(10)
    .shadow(
      color: .shadow,
      radius: 3,
      x: 0.0,
      y: 0.0)
  }
}

#Preview {
  CardThumbnail(card: initialCards[0])
    .frame(
      width: Settings.thumbnailSize.width,
      height: Settings.thumbnailSize.height)
}
