//
//  SingleCardView.swift
//  Cards
//
//  Created by CPW Front Office iMac on 9/14/25.
//

import SwiftUI

struct SingleCardView: View {
  @Environment(\.scenePhase) private var scenePhase
  @Binding var card: Card
  @State private var currentModal: ToolbarSelection?

  var body: some View {
    NavigationStack {
      GeometryReader { proxy in
        CardDetailView(
          card: $card,
          viewScale: Settings.calculateScale(proxy.size))
        .frame(
          width: Settings.calculateSize(proxy.size).width,
          height: Settings.calculateSize(proxy.size).height)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .modifier(CardToolbar(
          currentModal: $currentModal,
          card: $card))
        .onDisappear {
          let screenshot = UIImage.screenshot(card: card, size: Settings.cardSize * 0.2)
          _ = screenshot.save(to: card.id.uuidString)
          card.uiImage = screenshot
          card.save()
        }
        .onChange(of: scenePhase) { _, newScenePhase in
          if newScenePhase == .inactive {
            card.save()
          }
        }
      }
    }
  }
}

#Preview {
  @Previewable @State var card = initialCards[1]
  SingleCardView(card: $card)
    .environmentObject(CardStore(defaultData: true))
}
