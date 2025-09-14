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
        RoundedRectangle(cornerRadius: 15)
            .foregroundStyle(card.backgroundColor)
            .frame(width: Settings.thumbnailSize.width, height: Settings.thumbnailSize.height)
    }

}

#Preview(traits: .sizeThatFitsLayout) {
    CardThumbnail(card: initialCards[0])
}
