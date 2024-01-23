//
//  StatsActivity.swift
//  FutPlanner
//
//  Created by Pablo Rico alvarez on 23/1/24.
//

import SwiftUI

struct StatsActivity: View {
    var player: Player
    var body: some View {
        VStack {
            Text(player.first_name + " " + player.last_name).bold().font(.title2)
            Divider()
            ScrollView {
                VStack {
                    
                }
            }
            Spacer()
        }.padding(.top, 10).navigationBarTitle("Estadisticas de " + player.first_name, displayMode: .inline)
    }
}

#Preview {
    StatsActivity(player: team.players[0])
}
