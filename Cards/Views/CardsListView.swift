//
//  CardsListView.swift
//  Cards
//
//  Created by CPW Front Office iMac on 9/14/25.
//

import SwiftUI

struct CardsListView: View {
  @Environment(\.horizontalSizeClass) var horizontalSizeClass
  @Environment(\.verticalSizeClass) var verticalSizeClass
  @EnvironmentObject var store: CardStore
  @State private var selectedCard: Card?
  @Namespace private var namespace
  @State private var listState: ListState = .list

  var columns: [GridItem] {
    [
      GridItem(.adaptive(
        minimum: thumbnailSize.width))
    ]
  }

  var thumbnailSize: CGSize {
    var scale: CGFloat = 1
    if verticalSizeClass == .regular,
      horizontalSizeClass == .regular {
      scale = 1.5
    }
    return Settings.thumbnailSize * scale
  }

  var initialView: some View {
    VStack {
      let card = Card(
        backgroundColor: Color(
          uiColor: .systemBackground))
      ZStack {
        CardThumbnail(card: card)
        Image(systemName: "plus.circle.fill")
          .font(.largeTitle)
      }
      .onTapGesture {
        selectedCard = store.addCard()
      }
    }
    .frame(
      width: thumbnailSize.width * 1.2,
      height: thumbnailSize.height * 1.2)
    .padding(.bottom, 20)
  }

  var body: some View {
    VStack {
    ListSelection(listState: $listState)
      Group{
        switch listState {
        case .list:
          list
        case .carousel:
          Carousel(selectedCard: $selectedCard)
        }
      }
        .overlay {
          if store.cards.isEmpty {
            ContentUnavailableView {
              initialView
            } description: {
              Text("Tap the plus button to add a card")
            }
          }
        }
        .fullScreenCover(item: $selectedCard) { card in
          if let index = store.index(for: card) {
            SingleCardView(card: $store.cards[index])
              .navigationTransition(.zoom(sourceID: card.id, in: namespace))
              .interactiveDismissDisabled(true)
          } else {
            fatalError("Unable to locate selected card")
          }
        }
      createButton
    }
    .background(
      Color.background
        .ignoresSafeArea())
  }

  var list: some View {
    ScrollView(showsIndicators: false) {
      LazyVGrid(columns: columns, spacing: 30) {
        ForEach(store.cards) { card in
          CardThumbnail(card: card)
            .contextMenu {
              Button(role: .destructive) {
                store.remove(card)
              } label: {
                Label("Delete", systemImage: "trash")
              }
            }
            .frame(
              width: thumbnailSize.width,
              height: thumbnailSize.height)
            .onTapGesture {
              selectedCard = card
            }
            .matchedTransitionSource(id: card.id, in: namespace)
        }
      }
    }
    .padding(.top, 20)
  }

  var createButton: some View {
    Button {
      selectedCard = store.addCard()
    } label: {
      Label("Create New", systemImage: "plus")
        .frame(maxWidth: .infinity)
    }
    .font(.system(size: 16, weight: .bold))
    .padding([.top, .bottom], 10)
    .background(Color.bar)
    .accentColor(.white)
  }
}

#Preview {
  CardsListView()
    .environmentObject(CardStore(defaultData: true))
}
