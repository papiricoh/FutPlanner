//
//  TeamTab.swift
//  FutPlanner
//
//  Created by Pablo Rico alvarez on 16/1/24.
//

import SwiftUI

struct TeamTab: View {
    @State var searchText: String = ""
    
    var body: some View {
        VStack(alignment: .center) {
            Text(team.team_name).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).bold()
            Divider()
            VStack(alignment: .leading) {
                Text("TODO: GENERADOR DE ALINEACIONES")
                Text("Lista de jugadores:").font(.title3).bold()
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField("Buscar jugador", text: $searchText)
                                    .padding()
                }.padding(4).padding(.horizontal, 14).background(Color.futGrey).cornerRadius(10)
                ScrollView {
                    ForEach(filteredPlayers, id: \.id) { player in
                        PlayerRow(player: player)
                    }.animation(.default, value: searchText)
                }
            }
            Spacer()
        }.padding()
    }
    var filteredPlayers: [TPlayer] {
        if searchText.isEmpty {
            return team.players
        } else {
            return team.players.filter { player in
                player.first_name.lowercased().contains(searchText.lowercased()) ||
                player.last_name.lowercased().contains(searchText.lowercased())
            }
        }
    }
}

extension View {
    func keyboardDoneButton() -> some View {
        self
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        hideKeyboard()
                    }
                }
            }
    }

    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#Preview {
    TeamTab()
}
