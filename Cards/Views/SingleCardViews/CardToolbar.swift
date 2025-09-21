//
//  CardToolbar.swift
//  Cards
//
//  Created by CPW Front Office iMac on 9/14/25.
//

import SwiftUI

struct CardToolbar: ViewModifier {
  @Environment(\.dismiss) var dismiss
  @EnvironmentObject var store: CardStore
  @Binding var currentModal: ToolbarSelection?
  @Binding var card: Card
  @State private var stickerImage: UIImage?
  @State private var frameIndex: Int?
  @State private var textElement = TextElement()

  func body(content: Content) -> some View {
    content
    .toolbar {
      ToolbarItem(placement: .topBarTrailing) {
        menu
      }
      ToolbarItem(placement: .topBarTrailing) {
        Button("Done") {
          dismiss()
        }
      }
      ToolbarItem(placement: .topBarLeading) {
        let uiImage = UIImage.screenshot(card: card, size: Settings.cardSize)
        let image = Image(uiImage: uiImage)
        ShareLink(item: image, preview: SharePreview("Card", image: image)) {
          Image(systemName: "square.and.arrow.up")
        }
      }
      ToolbarItem(placement: .bottomBar) {
        BottomToolbar(
          card: $card,
          modal: $currentModal)
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
      case .frameModal:
        FrameModal(frameIndex: $frameIndex)
          .onDisappear {
            if let frameIndex {
              card.update(
                store.selectedElement,
                frameIndex: frameIndex)
            }
            frameIndex = nil
          }
      case .textModal:
        TextModal(textElement: $textElement)
          .onDisappear {
            if !textElement.text.isEmpty {
              card.addElement(text: textElement)
            }
            textElement = TextElement()
          }
      default:
        Text(String(describing: item))
      }
    }
  }

  var menu: some View {
    Menu {
      Button {
        if UIPasteboard.general.hasImages {
          if let images = UIPasteboard.general.images {
            for image in images {
              card.addElement(uiImage: image)
            }
          }
        } else if UIPasteboard.general.hasStrings {
          if let strings = UIPasteboard.general.strings {
            for text in strings {
              card.addElement(text: TextElement(text: text))
            }
          }
        }
      } label: {
        Label("Paste", systemImage: "doc.on.clipboard")
      }
      .disabled(!UIPasteboard.general.hasImages
        && !UIPasteboard.general.hasStrings)
    } label: {
      Label("Add", systemImage: "ellipsis.circle")
    }
  }
}

#Preview {
  Color.yellow
    .modifier(CardToolbar(
      currentModal: .constant(nil),
      card: .constant(Card())))
    .environmentObject(CardStore(defaultData: true))
}
