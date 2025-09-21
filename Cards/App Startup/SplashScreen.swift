//
//  SplashScreen.swift
//  Cards
//
//  Created by CPW Front Office iMac on 9/21/25.
//

import SwiftUI

struct SplashScreen: View {
    var body: some View {
      ZStack {
        Color("background")
          .ignoresSafeArea()
        card(letter: "S", color: "appColor1")
          .splashAnimation(finalYposition: 240, delay: 0)
        card(letter: "D", color: "appColor2")
          .splashAnimation(finalYposition: 120, delay: 0.2)
        card(letter: "R", color: "appColor3")
          .splashAnimation(finalYposition: 0, delay: 0.4)
        card(letter: "A", color: "appColor6")
          .splashAnimation(finalYposition: -120, delay: 0.6)
        card(letter: "C", color: "appColor7")
          .splashAnimation(finalYposition: -240, delay: 0.8)
      }
    }
  
  func card(letter: String, color: String) -> some View {
    ZStack {
      RoundedRectangle(cornerRadius: 25)
        .shadow(radius: 3)
        .frame(width: 120, height: 160)
        .foregroundStyle(.white)
      Text(letter)
        .fontWeight(.bold)
        .scalableText()
        .foregroundStyle(Color(color))
        .frame(width: 80)
    }
  }
}

private struct SplashAnimation: ViewModifier {
  @State private var animating = true
  let finalYPosition: CGFloat
  let delay: Double
  
  func body(content: Content) -> some View {
    content
      .offset(y: animating ? -700 : finalYPosition)
      .rotationEffect(animating ? .zero : Angle(degrees: Double.random(in: -10...10)))
      .animation(Animation.snappy(duration: 0.5, extraBounce: 0.2).delay(delay), value: animating)
      .onAppear {
          animating = false
      }
  }
}

private extension View {
  func splashAnimation(finalYposition: CGFloat, delay: Double) -> some View {
    modifier(SplashAnimation(finalYPosition: finalYposition, delay: delay))
  }
}

#Preview {
    SplashScreen()
}
