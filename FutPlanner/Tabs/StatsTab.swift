//
//  StatsTab.swift
//  FutPlanner
//
//  Created by Pablo Rico alvarez on 22/1/24.
//

import SwiftUI
import Charts
import Alamofire

struct StatsTab: View {
    @Binding var loading: Bool
    
    @State var data: [Develompent] = []
    @State var totals: [Int] = [0, 0, 0, 0, 0, 0]
    @State var dataEmpty: Bool = false
    
    var body: some View {
        VStack {
            Text("Estadisticas").font(.system(size: 30)).bold()
            Divider()
            ScrollView() {
                Text("Resumen del equipo").bold()
                if(dataEmpty) {
                    Text("No hay datos todavia").frame(height: 300).padding()
                }else if(data.isEmpty) {
                    LoadingComponent().frame(height: 300).padding()
                }else {
                    Chart(data) { dev in
                        BarMark(
                            x: .value("Clase", dev.classification),
                            y: .value("Puntuacion", dev.points)
                        ).foregroundStyle(devCheckColor(dev)).annotation(position: .overlay, alignment: .bottom) {
                            Text("\(dev.points, specifier: "%.1f")")
                                .foregroundColor(.white)
                        }
                    }.frame(height: 200).padding().cornerRadius(20).bold()
                    TotalStatsView(data: self.totals)
                    
                }
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
            Task() {
                do {
                    try await fetchAnalytics()
                }catch {
                    print(error)
                }
            }
        }
    }
    
    
    func fetchAnalytics() async throws {
        let url = "\(apiDir)/api/trainer/getTeamAnalytics"
        let parameters: [String: String] = [
            "user_id": "\(user?.id ?? 6)",
            "token": user?.lastTokenKey ?? ""
        ]
        
        do {
            let response: DataResponse<TeamAnalytic, AFError> = await AF.request(
                url,
                method: .post,
                parameters: parameters,
                encoding: JSONEncoding.default
            ).serializingDecodable(TeamAnalytic.self).response
            
            switch response.result {
            case .success(let analytics):
                //print(analytics) //Debug Print
                if(analytics.total_reports == 0) {
                    self.dataEmpty = true
                    return
                }
                    
                //Primary chart data:
                var newData: [Develompent] = []
                newData.append(Develompent(classification: "General", points: analytics.avg_general_performance ?? 0))
                newData.append(Develompent(classification: "Tactica", points: analytics.avg_tactical_performance ?? 0))
                newData.append(Develompent(classification: "Pases", points: analytics.avg_passes_quality ?? 0))
                newData.append(Develompent(classification: "Control", points: analytics.avg_ball_control ?? 0))
                newData.append(Develompent(classification: "Vision", points: analytics.avg_game_vision ?? 0))
                
                self.data = newData
                
                
                //Totals data
                var newTotals: [Int] = []
                newTotals.append(analytics.total_reports)
                newTotals.append(analytics.total_matches)
                newTotals.append(Int(analytics.total_played_time!))
                newTotals.append(Int(analytics.total_goals!))
                newTotals.append(Int(analytics.total_red_cards!))
                newTotals.append(Int(analytics.total_yellow_cards!))
                
                self.totals = newTotals
                
                
                
            case .failure(let error):
                print("Request failed with error: \(error)")
                throw error
            }
        } catch {
            print("Error in network request or decoding: \(error)")
            throw error
        }
    }
    
    func devCheckColor(_ dev: Develompent) -> Color {
        if(dev.points < 3) {
            return Color.red
        }
        if(dev.points < 6) {
            return Color.yellow
        }
        
        return Color.futGreenLight
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
