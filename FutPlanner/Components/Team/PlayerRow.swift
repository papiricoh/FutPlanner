//
//  PlayerRow.swift
//  FutPlanner
//
//  Created by Pablo Rico alvarez on 16/1/24.
//

import SwiftUI

struct PlayerRow: View {
    var player: Player
    @State var isDataOpen: Bool = false
    
    var body: some View {
        VStack {
            Button(action: {
                self.isDataOpen = !self.isDataOpen
            }, label: {
                HStack {
                    Image(systemName: "person.fill").frame(width: 80, height: 80).font(.largeTitle).cornerRadius(8)
                    VStack(alignment: .leading) {
                        Text(player.first_name + " " + player.last_name)
                        Text(formatDate(player.date_of_birth))
                    }
                    Spacer()
                    Image(systemName: "arrowshape.forward.fill").font(.title3).padding().rotationEffect(.degrees(isDataOpen ? 90 : 0))
                }
            })
            if(isDataOpen) {
                Divider()
                HStack() {
                    Text("DJWDO")
                }.padding()
            }
        }.padding(4).background(Color.futBlue).cornerRadius(8).foregroundStyle(Color.black).animation(.default, value: isDataOpen)
    }
    
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.locale = Locale(identifier: "es_ES")

        return formatter.string(from: date)
    }
}

#Preview {
    PlayerRow(player: team.players[0])
}
