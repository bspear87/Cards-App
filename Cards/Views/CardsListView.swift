//
//  CardsListView.swift
//  Cards
//
//  Created by CPW Front Office iMac on 9/14/25.
//

import SwiftUI

struct CardsListView: View {
    @EnvironmentObject var store: CardStore
    @State private var selectedCard: Card?
    
    var list: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                ForEach(store.cards) { card in
                    CardThumbnail(card: card)
                        .onTapGesture {
                            selectedCard = card
                        }
                }
            }
        }
        .fullScreenCover(item: $selectedCard) { card in
            if let index = store.index(for: card) {
                SingleCardView(card: $store.cards[index])
            } else {
                fatalError("Unable to lacate selected card")
            }
        }
    }
    
    var body: some View {
        list
    }
}

#Preview {
    CardsListView()
        .environmentObject(CardStore(defaultData: true))
}
