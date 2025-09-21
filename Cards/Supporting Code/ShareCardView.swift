//
//  ShareCardView.swift
//  Cards
//
//  Created by CPW Front Office iMac on 9/21/25.
//

import SwiftUI

struct ShareCardView: View {
  let card: Card

  var body: some View {
    GeometryReader { proxy in
      content(size: proxy.size)
    }
  }

  func content(size: CGSize) -> some View {
    card.backgroundColor
    .overlay {
      elements(size: size)
    }
    .frame(
      width: Settings.calculateSize(size).width,
      height: Settings.calculateSize(size).height)
  }

  func elements(size: CGSize) -> some View {
    let viewScale = Settings.calculateScale(size)
    return ForEach(card.elements, id: \.id) { element in
      CardElementView(element: element)
        .frame(
          width: element.transform.size.width,
          height: element.transform.size.height)
        .rotationEffect(element.transform.rotation)
        .scaleEffect(viewScale)
        .offset(element.transform.offset * viewScale)
    }
  }
}

#Preview {
  ShareCardView(card: initialCards[0])
}
