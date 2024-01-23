//
//  PlayerListItem.swift
//  FutPlanner
//
//  Created by Pablo Rico alvarez on 23/1/24.
//

import SwiftUI

struct PlayerListItem: View {
    var text: String
    @State private var isPressed = false
    
    var body: some View {
        VStack {
            Divider()
            HStack {
                Text(text)
                Spacer()
                Image(systemName: "arrowshape.right.circle.fill").font(.system(size: 20))
            }.padding().bold()
        }
    }
}

#Preview {
    PlayerListItem(text: "Pablo Lopez")
}
