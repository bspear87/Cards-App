//
//  CardsApp.swift
//  Cards
//
//  Created by CPW Front Office iMac on 9/21/25.
//

import SwiftUI

@main
struct CardsApp: App {
  @StateObject var store = CardStore(defaultData: false)

  var body: some Scene {
    WindowGroup {
      AppLoadingView()
        .environmentObject(store)
        .onAppear {
          print(URL.documentsDirectory)
        }
    }
  }
}
