//
//  TeamTab.swift
//  FutPlanner
//
//  Created by Pablo Rico alvarez on 16/1/24.
//

import SwiftUI

struct TeamTab: View {
    var body: some View {
        VStack(alignment: .center) {
            Text("Nombre de tu equipo").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).bold()
            Divider()
            VStack(alignment: .leading) {
                Text("TODO: GENERADOR DE ALINEACIONES")
                Text("Lista de jugadores:").font(.title3).bold()
                ScrollView {
                    PlayerRow()
                }
            }
            Spacer()
        }.padding()
    }
}

#Preview {
    TeamTab()
}
