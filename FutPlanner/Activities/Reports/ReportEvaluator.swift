//
//  ReportEvaluator.swift
//  FutPlanner
//
//  Created by Pablo Rico alvarez on 7/2/24.
//

import SwiftUI

struct ReportEvaluator: View {
    @Environment(\.presentationMode) var presentationMode
    
    var players: [TPlayer]
    var match: MatchInfo
    @State var reports: [PlayerReport] = []
    @State var currentPlayerIndex = 0
    @State var currentReport: PlayerReport = PlayerReport(id: 0, playerId: 0, matchId: 0, generalPerformance: 1, tacticalPerformance: 1, passesQuality: 1, ballControl: 1, gameVision: 1, playedTime: 0.0, goals: 0, redCards: 0, yellowCards: 0)
    @State private var onSlider = false
    @State private var scrollPosition: Int?
    
    func nextCommand(isLast: Bool) -> Void {
        self.currentReport.playerId = players[self.currentPlayerIndex].id
        self.reports.append(self.currentReport)
        //TODO: FETCH
        self.currentReport = PlayerReport(id: 0, playerId: 0, matchId: 0, generalPerformance: 1, tacticalPerformance: 1, passesQuality: 1, ballControl: 1, gameVision: 1, playedTime: 0.0, goals: 0, redCards: 0, yellowCards: 0)
        if(!isLast) {
            self.currentPlayerIndex += 1
        }else {
            //todo fetch to send all data
            if let index = matches.firstIndex(where: { $0.id == self.match.id }) {
                matches[index].evaluated = true
            }

            self.presentationMode.wrappedValue.dismiss()
        }
    }
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                VStack{
                    ProfileCard(player: players[currentPlayerIndex]).id("Card")
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
                        HStack(alignment: .center) {
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
                                nextCommand(isLast: false)
                                proxy.scrollTo("Card", anchor: .top)
                            } label: {
                                HStack{
                                    Text("Siguiente")
                                    Image(systemName: "arrow.right").font(.title2).bold()
                                }
                            }.padding(16).padding(.horizontal, 70).background(Color.futGreen).cornerRadius(8).foregroundColor(.white)
                        }else {
                            Button {
                                nextCommand(isLast: true)
                            } label: {
                                Text("Finalizar").font(.title2).bold()
                            }.padding(16).padding(.horizontal, 70).background(Color.futGreen).cornerRadius(10).foregroundColor(.white)
                        }
                    }.padding()
                }
            }
        }
    }
}

#Preview {
    ReportEvaluator(players: team.players, match: matches[0])
}
