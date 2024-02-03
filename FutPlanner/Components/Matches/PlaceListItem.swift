//
//  ListItem.swift
//  FutPlanner
//
//  Created by Pablo Rico alvarez on 22/1/24.
//

import SwiftUI

struct PlaceListItem: View {
    var text: String
    @State private var isPressed = false
    
    var body: some View {
        Divider()
        Text(text).padding().frame(width: UIScreen.main.bounds.width - 60).background(isPressed ? Color.gray : Color.futDay).cornerRadius(10).bold().gesture(DragGesture(minimumDistance: 0).onChanged({ _ in self.isPressed = true }).onEnded({ _ in self.isPressed = false })).animation(.default, value: isPressed)
    }
}

#Preview {
    PlaceListItem(text: "Hola")
}
