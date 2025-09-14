//
//  CardsApp.swift
//  Cards
//
//  Created by CPW Front Office iMac on 9/14/25.
//

import SwiftUI

@main
struct CardsApp: App {
    @StateObject var store = CardStore(defaultData: true)
    
    var body: some Scene {
        WindowGroup {
            CardsListView()
                .environmentObject(store)
        }
    }
}
