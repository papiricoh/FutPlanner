//
//  BottomSheetView.swift
//  FutPlanner
//
//  Created by Pablo Rico alvarez on 18/1/24.
//

import SwiftUI

struct CreateMatchSheetView: View {
    @Binding var isPresented: Bool
    @GestureState private var dragState = DragState.inactive

    var body: some View {
        VStack {
            Text("Hell yeah")
        }
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(10)
        .offset(y: dragState.translation.height)
        .gesture(
            DragGesture().updating($dragState) { drag, state, transaction in
                state = .dragging(translation: drag.translation)
            }
            .onEnded { drag in
                if drag.translation.height > 100 {
                    isPresented = false
                }
            }
        )
    }

    enum DragState {
        case inactive
        case dragging(translation: CGSize)

        var translation: CGSize {
            switch self {
            case .inactive:
                return .zero
            case .dragging(let translation):
                return translation
            }
        }
    }
}


#Preview {
    CreateMatchSheetView(isPresented: .constant(true))
}
