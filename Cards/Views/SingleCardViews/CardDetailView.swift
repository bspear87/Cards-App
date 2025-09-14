//
//  SwiftUIView.swift
//  Cards
//
//  Created by CPW Front Office iMac on 9/14/25.
//

import SwiftUI

struct CardDetailView: View {
    @Binding var card: Card
    
    var body: some View {
        ZStack {
            card.backgroundColor
            
            ForEach($card.elements, id: \.id) { $element in
                CardElementView(element: element)
                    .resizableView(transform: $element.transform)
                    .frame(width: element.transform.size.width, height: element.transform.size.height)
            }
        }
    }
}

#Preview {
    @Previewable @State var card = initialCards[0]
    CardDetailView(card: $card)
        .environmentObject(CardStore(defaultData: true))
}
