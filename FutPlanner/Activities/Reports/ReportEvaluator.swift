//
//  ReportEvaluator.swift
//  FutPlanner
//
//  Created by Pablo Rico alvarez on 7/2/24.
//

import SwiftUI

struct ReportEvaluator: View {
    var players: [Player]
    var match: MatchInfo
    @State var reports: [PlayerReport] = []
    @State var currentPlayerIndex = 0
    @State var currentReport: PlayerReport = PlayerReport(id: 0, playerId: 0, matchId: 0, generalPerformance: 1, tacticalPerformance: 1, passesQuality: 1, ballControl: 1, gameVision: 1, playedTime: 0.0, goals: 0, redCards: 0, yellowCards: 0)
    @State private var onSlider = false
    
    var body: some View {
        ScrollView {
            VStack{
                Text(players[currentPlayerIndex].first_name + " " + players[currentPlayerIndex].last_name).font(.title).bold() //todo playerCard
                VStack {//EV Process
                    RatingComponent(text: "Rendimiento General", rating: $currentReport.generalPerformance)
                    RatingComponent(text: "Rendimiento Tactico", rating: $currentReport.tacticalPerformance)
                    RatingComponent(text: "Calidad de pases", rating: $currentReport.passesQuality)
                    RatingComponent(text: "Control de Balon", rating: $currentReport.ballControl)
                    RatingComponent(text: "Vision de juego", rating: $currentReport.gameVision)
                    VStack(alignment: .leading) {
                        Text("Tiempo de Juego").font(.title3).bold()
                        Slider(
                            value: $currentReport.playedTime,
                            in: 0...100,
                            onEditingChanged: { on in
                                onSlider = on
                            }
                        )
                        Text("\(Int(currentReport.playedTime)) mins")
                            .foregroundColor(onSlider ? .red : .blue)
                    }.padding(.horizontal, 30.0)
                    HStack {
                        NumericAssignComponent(text: "Goles", img: "soccerball", imgColor: Color.futNight, num: $currentReport.goals)
                        Spacer()
                        NumericAssignComponent(text: "Amarillas", img: "greetingcard.fill", imgColor: Color.yellow, num: $currentReport.yellowCards)
                        Spacer()
                        NumericAssignComponent(text: "Rojas", img: "greetingcard.fill", imgColor: Color.red, num: $currentReport.redCards)
                    }.padding(.horizontal, 30.0).padding(.vertical, 10)
                }
                Spacer()
                HStack() {
                    if(currentPlayerIndex + 1 < players.count) {
                        Button {
                            
                        } label: {
                            Image(systemName: "arrow.right").font(.title2).bold()
                        }.padding(16).background(Color.futGrey).cornerRadius(10)
                    }else {
                        Button {
                            
                        } label: {
                            Text("Finalizar").font(.title2).bold()
                        }.padding(16).background(Color.futGrey).cornerRadius(10)
                    }
                }.padding()
            }
        }
    }
}

#Preview {
    ReportEvaluator(players: team.players, match: matches[0])
}
