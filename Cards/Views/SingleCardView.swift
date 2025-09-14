//
//  SingleCardView.swift
//  Cards
//
//  Created by CPW Front Office iMac on 9/14/25.
//

import SwiftUI

struct SingleCardView: View {
    @State private var currentModal: ToolbarSelection?
    
    @Binding var card: Card
    
    var content: some View {
        card.backgroundColor
    }
    
    var body: some View {
        NavigationStack {
            CardDetailView(card: $card)
                .modifier(CardToolbar(currentModal: $currentModal, card: $card))
        }
    }
}

#Preview {
    @Previewable @State var card = initialCards[0]
    SingleCardView(card: $card)
}
