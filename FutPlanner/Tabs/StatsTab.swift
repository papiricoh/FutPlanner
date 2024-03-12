//
//  StatsTab.swift
//  FutPlanner
//
//  Created by Pablo Rico alvarez on 22/1/24.
//

import SwiftUI
import Charts

struct StatsTab: View {
    @Binding var loading: Bool
    
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
                        x: .value("Clase", dev.classification),
                        y: .value("Puntuacion", dev.points)
                    ).foregroundStyle(Color.futGreenLight)
                }.frame(height: 300).padding().cornerRadius(20).bold()
                VStack(alignment: .center) {
                    ForEach(fTeam?.players ?? [], id: \.id) { player in
                        NavigationLink(destination: StatsActivity(player: player, loading: $loading)) {
                            PlayerListItem(text: player.firstName + " " + player.lastName)
                        }
                    }
                }
                
            }
            Spacer()
        }.padding(.top, 10).onAppear() {
            loading = false
        }
    }
}

struct Develompent: Identifiable {
    var id = UUID()
    let classification: String
    let points: Double
}

#Preview {
    StatsTab(loading: .constant(false))
}
