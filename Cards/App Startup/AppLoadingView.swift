//
//  AppLoadingView.swift
//  Cards
//
//  Created by CPW Front Office iMac on 9/21/25.
//

import SwiftUI

struct AppLoadingView: View {
  @State private var showSplash = true
    var body: some View {
        if showSplash {
        SplashScreen()
            .ignoresSafeArea()
            .onAppear {
              withAnimation(.linear(duration: 1.0)
                .delay(1.5)) {
                  showSplash = false
                }
            }
        } else {
          CardsListView()
            .transition(.scale(scale: 0, anchor: .top))
        }
    }
}

#Preview {
    AppLoadingView()
    .environmentObject(CardStore(defaultData: true))
}
