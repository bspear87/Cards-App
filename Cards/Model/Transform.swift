//
//  Transform.swift
//  Cards
//
//  Created by CPW Front Office iMac on 9/14/25.
//

import SwiftUI

struct Transform {
    var size = CGSize (width: Settings.defaultElementSize.width, height: Settings.defaultElementSize.height)
    var rotation: Angle = .zero
    var offset: CGSize = .zero
}
