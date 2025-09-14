//
//  CardToolbar.swift
//  Cards
//
//  Created by CPW Front Office iMac on 9/14/25.
//

import SwiftUI

struct CardToolbar: ViewModifier {
  @Environment(\.dismiss) var dismiss
  @Binding var currentModal: ToolbarSelection?
  @Binding var card: Card
  @State private var stickerImage: UIImage?

  func body(content: Content) -> some View {
    content
    .toolbar {
      ToolbarItem(placement: .topBarTrailing) {
        Button("Done") {
          dismiss()
        }
      }
      ToolbarItem(placement: .bottomBar) {
        BottomToolbar(modal: $currentModal)
      }
    }
    .sheet(item: $currentModal) { item in
      switch item {
      case .stickerModal:
        StickerModal(stickerImage: $stickerImage)
          .onDisappear {
            if let stickerImage = stickerImage {
              card.addElement(uiImage: stickerImage)
            }
            stickerImage = nil
          }
      default:
        Text(String(describing: item))
      }
    }
  }
}

#Preview {
  Color.yellow
    .modifier(CardToolbar(
      currentModal: .constant(nil),
      card: .constant(Card())))
}
