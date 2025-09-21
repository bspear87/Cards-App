//
//  ResizableView.swift
//  Cards
//
//  Created by CPW Front Office iMac on 9/14/25.
//

import SwiftUI

struct ResizableView: ViewModifier {
  @Binding var transform: Transform
  @State private var previousOffset: CGSize = .zero
  @State private var previousRotation: Angle = .zero
  @State private var scale: CGFloat = 1.0

  let viewScale: CGFloat

  var dragGesture: some Gesture {
    DragGesture()
      .onChanged { value in
        transform.offset = value.translation / viewScale + previousOffset
      }
      .onEnded { _ in
        previousOffset = transform.offset
      }
  }

  var rotationGesture: some Gesture {
    RotationGesture()
      .onChanged { rotation in
        transform.rotation += rotation - previousRotation
        previousRotation = rotation
      }
      .onEnded { _ in
        previousRotation = .zero
      }
  }

  var scaleGesture: some Gesture {
    MagnificationGesture()
      .onChanged { scale in
        self.scale = scale
      }
      .onEnded { scale in
        transform.size.width *= scale
        transform.size.height *= scale
        self.scale = 1.0
      }
  }

  func body(content: Content) -> some View {
    content
      .frame(
        width: transform.size.width * viewScale,
        height: transform.size.height * viewScale)
      .rotationEffect(transform.rotation)
      .scaleEffect(scale)
      .offset(transform.offset * viewScale)
      .gesture(dragGesture)
      .gesture(SimultaneousGesture(rotationGesture, scaleGesture))
      .onAppear {
        previousOffset = transform.offset
      }
  }
}

#Preview {
  @Previewable @State var transform = Transform()
  RoundedRectangle(cornerRadius: 30)
    .foregroundStyle(.blue)
    .resizableView(transform: $transform)
}

extension View {
  func resizableView(
    transform: Binding<Transform>,
    viewScale: CGFloat = 1.0
) -> some View {
    modifier(ResizableView(
      transform: transform,
      viewScale: viewScale))
  }
}
