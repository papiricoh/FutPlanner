//
//  StatsTab.swift
//  FutPlanner
//
//  Created by Pablo Rico alvarez on 22/1/24.
//

import SwiftUI
import Charts

struct StatsTab: View {
    
    let data: [Develompent] = [
        Develompent(classification: "Nivel Tecnico", points: 11),
        Develompent(classification: "Nivel Competitivo", points: 12),
        Develompent(classification: "Nivel Defensivo", points: 15),
        Develompent(classification: "Nivel Centro", points: 10),
        Develompent(classification: "Nivel Ofensivo", points: 23)
    ]
    
    var body: some View {
        VStack {
            Text("Estadisticas").font(.system(size: 30)).bold()
            Divider()
            ScrollView() {
                Text("Resumen del equipo").bold()
                Chart(data) { dev in
                    BarMark(
                        x: .value("Department", dev.classification),
                        y: .value("Profit", dev.points)
                    ).foregroundStyle(Color.futGreenLight)
                }.frame(height: 300).padding().cornerRadius(20).bold()
                VStack(alignment: .center) {
                    ForEach(team.players, id: \.id) { player in
                        NavigationLink(destination: StatsActivity(player: player)) {
                            PlayerListItem(text: player.first_name + " " + player.last_name)
                        }
                    }
                }
                
            }
            Spacer()
        }.padding(.top, 10)
    }
}

struct Develompent: Identifiable {
    var id = UUID()
    let classification: String
    let points: Double
}

#Preview {
    StatsTab()
}
