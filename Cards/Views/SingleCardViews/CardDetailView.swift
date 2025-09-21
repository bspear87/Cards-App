//
//  SwiftUIView.swift
//  Cards
//
//  Created by CPW Front Office iMac on 9/14/25.
//

import SwiftUI

struct CardDetailView: View {
  @EnvironmentObject var store: CardStore
  @Binding var card: Card
  var viewScale: CGFloat = 1

  func isSelected(_ element: CardElement) -> Bool {
    store.selectedElement?.id == element.id
  }

  var body: some View {
    card.backgroundColor
      .onTapGesture {
        store.selectedElement = nil
      }
      .overlay {
        ForEach($card.elements, id: \.id) { $element in
          CardElementView(element: element)
            .overlay(
              element: element,
              isSelected: isSelected(element))
            .elementContextMenu(
              card: $card,
              element: $element)
            .resizableView(
              transform: $element.transform,
              viewScale: viewScale)
            .frame(
              width: element.transform.size.width,
              height: element.transform.size.height)
            .onTapGesture {
              store.selectedElement = element
            }
        }
      }
      .clipped()
      .onDisappear {
        store.selectedElement = nil
      }
      .dropDestination(for: CustomTransfer.self) { items, location in
        let offset = Settings.calculateDropOffset(
          viewScale: viewScale,
          location: location)
        Task {
          await MainActor.run {
            card.addElements(
              from: items,
              at: offset)
          }
        }
        return !items.isEmpty
      }
  }
}

#Preview {
  @Previewable @State var card = initialCards[0]
  CardDetailView(card: $card, viewScale: 0.3)
    .environmentObject(CardStore(defaultData: true))
}

private extension View {
  @ViewBuilder
  func overlay(
    element: CardElement,
    isSelected: Bool
  ) -> some View {
    if isSelected,
       let element = element as? ImageElement,
       let frameIndex = element.frameIndex {
      let shape = Shapes.shapes[frameIndex]
      self.overlay(shape
        .stroke(lineWidth: Settings.borderWidth)
        .foregroundStyle(Settings.borderColor))
    } else {
      self
        .border(
          Settings.borderColor,
          width: isSelected ? Settings.borderWidth : 0)
    }
  }
}
