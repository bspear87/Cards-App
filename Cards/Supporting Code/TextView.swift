//
//  TextView.swift
//  Cards
//
//  Created by CPW Front Office iMac on 9/21/25.
//

import SwiftUI

struct TextView: View {
  @Binding var font: String
  @Binding var color: Color

  var body: some View {
    VStack {
      ScrollView(.horizontal, showsIndicators: false) {
        HStack {
          fonts
        }
        .frame(maxWidth: .infinity)
        .frame(height: 100)
      }
      HStack {
        colors
      }
    }
    .frame(maxWidth: .infinity)
    .padding([.top, .bottom])
    .background(Color.primary)
  }

  var fonts: some View {
    ForEach(0..<AppFonts.fonts.count, id: \.self) { index in
      ZStack {
        Circle()
          .foregroundStyle(.primary)
          .colorInvert()
        Text("Aa")
          .font(.custom(AppFonts.fonts[index], size: 20))
          .fontWeight(.heavy)
          .foregroundStyle(.primary)
      }
      .frame(
        width: AppFonts.fonts[index] == font ? 50 : 40,
        height: AppFonts.fonts[index] == font ? 50 : 40)
      .onTapGesture {
        withAnimation {
          font = AppFonts.fonts[index]
        }
      }
    }
  }

  var colors: some View {
    ForEach(1..<8) { index in
      let currentColor = Color("appColor\(index)")
      ZStack {
        Circle()
          .stroke(Color.white, lineWidth: 1.0)
          .overlay(
            Circle()
              .foregroundStyle(color == currentColor ? currentColor : .white))
          .frame(
            width: 44,
            height: 44)
        Circle()
          .stroke(lineWidth: color == currentColor ? 0 : 1)
          .overlay(
            Circle()
              .foregroundStyle(currentColor))
          .frame(
            width: color == currentColor ? 50 : 40,
            height: color == currentColor ? 50 : 40)
      }
      .onTapGesture {
        withAnimation {
          color = Color("appColor\(index)")
        }
      }
    }
  }
}

#Preview {
  TextView(
    font: .constant("San Fransisco"),
    color: .constant(Color("appColor2")))
}
