//
//  ReportEvaluator.swift
//  FutPlanner
//
//  Created by Pablo Rico alvarez on 7/2/24.
//

import SwiftUI
import Alamofire

struct ReportEvaluator: View {
    @Environment(\.presentationMode) var presentationMode
    
    var players: [Player]
    var match: fMatch
    @State var reports: [PlayerReport] = []
    @State var currentPlayerIndex = 0
    @State var currentReport: PlayerReport = PlayerReport(id: 0, playerId: 0, matchId: 0, generalPerformance: 1, tacticalPerformance: 1, passesQuality: 1, ballControl: 1, gameVision: 1, playedTime: 0.0, goals: 0, redCards: 0, yellowCards: 0)
    @State private var onSlider = false
    @State private var scrollPosition: Int?
    var completeReport: () -> Void
    
    func nextCommand(isLast: Bool) -> Void {
        self.currentReport.playerId = players[self.currentPlayerIndex].playerId
        self.reports.append(self.currentReport)
        self.currentReport = PlayerReport(id: 0, playerId: 0, matchId: 0, generalPerformance: 1, tacticalPerformance: 1, passesQuality: 1, ballControl: 1, gameVision: 1, playedTime: 0.0, goals: 0, redCards: 0, yellowCards: 0)
        if(!isLast) {
            self.currentPlayerIndex += 1
        }else {
            //todo fetch to send all data
            print(self.reports)
            
            Task {
                do {
                    try await self.fetchInsertReports()
                    
                    DispatchQueue.main.async {
                        self.completeReport()
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }catch {
                    print("Error in request: \(error)")
                }
            }
        }
    }
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                VStack{
                    ProfileCard(player: self.players[self.currentPlayerIndex]).id("Card")
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
    func fetchInsertReports() async throws -> Void {
        let url = "\(apiDir)/api/trainer/insertReports"
        
        
        var reportsArray = [[String: Any]]()

        self.reports.forEach { report in
            let reportDict: [String: Any] = [
                "player_id": report.playerId,
                "general_performance": report.generalPerformance,
                "tactical_performance": report.tacticalPerformance,
                "passes_quality": report.passesQuality,
                "ball_controll": report.ballControl,
                "game_vision": report.gameVision,
                "played_time": report.playedTime,
                "goals": report.goals,
                "red_cards": report.redCards,
                "yellow_cards": report.yellowCards
            ]
            reportsArray.append(reportDict)
        }
        let jsonData = try JSONSerialization.data(withJSONObject: reportsArray, options: [])
        let jsonReports = try JSONSerialization.jsonObject(with: jsonData, options: [])

        let parameters: [String: Any] = [
            "user_id": "\(user?.id ?? 0)",
            "token": user?.lastTokenKey ?? "",
            "match_id": "\(self.match.id)",
            "reports": jsonReports  // Usar el objeto JSON directamente aquí
        ]
        
        // Si necesitas convertir parameters a Data para enviar en una solicitud HTTP, etc.
        let finalJsonData = try JSONSerialization.data(withJSONObject: parameters, options: [])
        let finalJsonString = String(data: finalJsonData, encoding: .utf8) ?? ""
        
        print("JSON Parameters String: \(finalJsonString)")
        
        do {
            guard let url = URL(string: "\(url)") else {
                print("Invalid URL")
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = finalJsonString.data(using: .utf8)
            
            
            let response: DataResponse<[Int], AFError> = await AF.request(request)
                .serializingDecodable([Int].self).response
                
            switch response.result {
            case .success(let list):
                print("Success: \(list)")
                return
            case .failure(let error):
                print("Request failed with error: \(error)")
                throw error
            }
        } catch {
            print("Error in network request or decoding: \(error)")
            throw error
        }
    }
}

#Preview {
    ReportEvaluator(players: [
        Player(id: 2, firstName: "Hola", lastName: "1", playerId: 3, position: "DI"),
        Player(id: 1, firstName: "Hola", lastName: "2", playerId: 1, position: "DC")
    ], match: fMatch(id: 1, homeTeamName: "", awayTeamName: "", category: "", subCategory: "", you: 1, date: Date(), coordinates_name: "", evaluated: false, coordinates: Coordinates(latitude: 2, longitude: 1), homeTeamId: 1, awayTeamId: 4), completeReport: {})
}
