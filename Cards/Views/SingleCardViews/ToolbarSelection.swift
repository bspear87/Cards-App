//
//  ToolbarSelection.swift
//  Cards
//
//  Created by CPW Front Office iMac on 9/21/25.
//

import Foundation

enum ToolbarSelection: CaseIterable, Identifiable {
  var id: Int {
    hashValue
  }

  case photoModal, frameModal, stickerModal, textModal
}
