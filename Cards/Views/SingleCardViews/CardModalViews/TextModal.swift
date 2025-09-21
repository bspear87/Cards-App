//
//  TextModal.swift
//  Cards
//
//  Created by CPW Front Office iMac on 9/21/25.
//

import SwiftUI

struct TextModal: View {
  @Environment(\.dismiss) var dismiss
  @Binding var textElement: TextElement
  
  var body: some View {
    let onCommit = {
      dismiss()
    }
    VStack {
      TextField(
        "Enter text", text: $textElement.text, onCommit: onCommit)
      .font(.custom(textElement.textFont, size: 30))
      .padding(20)
      TextView( font: $textElement.textFont, color: $textElement.textColor)
    }
  }
}
#Preview {
  TextModal(textElement: .constant(TextElement()))
}
