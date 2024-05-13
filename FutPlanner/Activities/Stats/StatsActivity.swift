//
//  StatsActivity.swift
//  FutPlanner
//
//  Created by Pablo Rico alvarez on 23/1/24.
//

import SwiftUI
import DGCharts
import Alamofire

struct StatsActivity: View {
    var player: Player
    @Binding var loading: Bool
    @State var playerReports: [Report] = []
    @State var noData: Bool = false
    
    
    var body: some View {
        VStack {
            if(!loading) {
                ProfileCard(player: player)
                if(noData) {
                    Divider()
                    Text("No Hay Datos").font(.title3).bold()
                    Divider()
                    Text("Prueba a evaluar un partido ya disputado")
                }else {
                    ScrollView {
                        VStack {
                            RadarChartRepresentable(reports: playerReports).frame(height: 400)
                            Divider()
                            VStack() {
                                Text("Medias y totales")
                                HStack() {
                                    HStack {
                                        Image(systemName: "soccerball").font(.title)
                                        Text("\(sumReports(playerReports).goals) Goles").bold()
                                    }.padding(.horizontal, 10).padding().frame(height:80).frame(width: 160).background(Color.futBlue).cornerRadius(10).padding(.horizontal, 20)
                                    Spacer()
                                    HStack {
                                        Image(systemName: "checkmark.gobackward").font(.title)
                                        Text("\(sumReports(playerReports).playedTime) Minutos").bold()
                                    }.padding(.horizontal, 10).padding().frame(height: 80).frame(width: 160).background(Color.futBlue).cornerRadius(10).padding(.horizontal, 20)
                                }
                                HStack() {
                                    HStack {
                                        Image(systemName: "greetingcard.fill").font(.title).foregroundStyle(Color.yellow)
                                        Text("\(sumReports(playerReports).yellowCards) Tarjetas").bold()
                                    }.padding(.horizontal, 10).padding().frame(height:80).frame(width: 160).background(Color.futBlue).cornerRadius(10).padding(.horizontal, 20)
                                    Spacer()
                                    HStack {
                                        Image(systemName: "greetingcard.fill").font(.title).foregroundStyle(Color.futRed)
                                        Text("\(sumReports(playerReports).redCards) Tarjetas").bold()
                                    }.padding(.horizontal, 10).padding().frame(height:80).frame(width: 160).background(Color.futBlue).cornerRadius(10).padding(.horizontal, 20)
                                }
                                HStack {
                                    Image(systemName: "figure.soccer").font(.title)
                                    Text("\(playerReports.count) Partidos jugados").bold()
                                }.padding(.horizontal, 10).padding().frame(height:80).background(Color.futBlue).cornerRadius(10).padding(.horizontal, 20)
                            }
                            Divider()
                            VStack {
                                ForEach(getPlayerReports(playerId: player.id)) { report in
                                    Text("\(searchMatch(matchId: report.matchId).homeTeamName)")
                                }
                            }
                            Spacer()
                        }
                        ReportList(reports: playerReports)
                    }
                }
                Spacer()
            }
        }.padding(.top, 10).navigationBarTitle("Estadisticas de " + player.firstName, displayMode: .inline).onAppear() {
            loading = true
            Task {
                do {
                    try await fetchReports()
                    
                    loading = false
                } catch {
                    print("Error en la solicitud: \(error.localizedDescription)")
                    noData = true
                    loading = false
                }
            }
        }
    }
    func sumReports(_ reports: [Report]) -> Report {
        var goals = 0
        var time = 0
        var yellow = 0
        var red = 0
        for i in reports {
            goals += i.goals
            time += i.playedTime
            yellow += i.yellowCards
            red += i.redCards
        }
        return Report(id: 0, playerId: 0, matchId: 0, generalPerformance: 0, tacticalPerformance: 0, passesQuality: 0, ballControl: 0, gameVision: 0, playedTime: time, goals: goals, redCards: red, yellowCards: yellow, match: Match(id: 0, matchDate: "0", mapCoords: "0", placeName: "0", homeTeamId: 0, homeTeamName: "0", awayTeamId: 0, awayTeamName: "0", subCategoryId: 0, evaluated: 0))
    }
    
    func fetchReports() async throws {
        let url = "\(apiDir)/api/trainer/getPlayerReports"
        let parameters: [String: String] = [
            "user_id": "\(user?.id ?? 0)",
            "token": user?.lastTokenKey ?? "",
            "player_user_id": "\(player.id)"
        ]

        
        let response: DataResponse<[Report], AFError> = await AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).serializingDecodable([Report].self).response
        switch response.result {
        case .success(let preports):
            self.playerReports = preports
        case .failure(let error):
            throw error
        }
    }

    func getPlayerReports(playerId: Int) -> [PlayerReport] {
        var reportsTotal: [PlayerReport] = []
        for report in reports {
            if(report.playerId == playerId) {
                reportsTotal.append(report)
            }
        }
        
        return reportsTotal
    }
    func searchMatch(matchId: Int) -> MatchInfo {
        for match in matches {
            if(match.id == matchId) {
                return match
            }
        }
        return MatchInfo(id: -1, homeTeamName: "String", awayTeamName: "String", category: "String", subCategory: "String", you: 1, date: Date(timeIntervalSince1970: 10), coordinates_name: "String", evaluated: false, coordinates: Coordinates(latitude: 1, longitude: 1))
    }
}
struct RadarChartRepresentable: UIViewControllerRepresentable {
    var reports: [Report]
    func makeUIViewController(context: Context) -> RadarChartViewController {
        return RadarChartViewController(reports: reports)
    }

    func updateUIViewController(_ uiViewController: RadarChartViewController, context: Context) {
    }
}

class RadarChartViewController: UIViewController {
    var radarChart: RadarChartView!
    var reports: [Report]
    
    init(reports: [Report]) {
        self.reports = reports
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        radarChart = RadarChartView(frame: self.view.bounds)
        radarChart.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        radarChart.rotationEnabled = false
        radarChart.yAxis.drawLabelsEnabled = false
        radarChart.legend.enabled = false
        radarChart.yAxis.axisMinimum = 0
        radarChart.yAxis.axisMaximum = 10 
        
        setupRadarChart()
        self.view.addSubview(radarChart)
    }

    func setupRadarChart() {
        
        let categories = ["Desempeño \nGeneral", "Desempeño \nTactico", "Calidad de\nPases", "Control\nBalon", "Vision\nde juego"]
        
        radarChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: categories)
        radarChart.xAxis.labelTextColor = .futNight 
        radarChart.xAxis.labelFont = .systemFont(ofSize: 12, weight: .bold)
        
        let averageGeneralPerformance = reports.map { $0.generalPerformance }.average()
        let averageTacticalPerformance = reports.map { $0.tacticalPerformance }.average()
        let averagePassesQuality = reports.map { $0.passesQuality }.average()
        let averageBallControl = reports.map { $0.ballControl }.average()
        let averageGameVision = reports.map { $0.gameVision }.average()
        
        let averages = [averageGeneralPerformance, averageTacticalPerformance, averagePassesQuality, averageBallControl, averageGameVision]
        
        let entries1 = averages.map { RadarChartDataEntry(value: Double($0)) }
        
        let set1 = RadarChartDataSet(entries: entries1, label: "Medias del jugador")
        set1.setColor(UIColor(red: 10/255, green: 110/255, blue: 10/255, alpha: 1))
        set1.fillColor = UIColor(red: 10/255, green: 110/255, blue: 10/255, alpha: 1)
        set1.drawFilledEnabled = true
        set1.fillAlpha = 0.7
        set1.lineWidth = 2
        set1.drawValuesEnabled = true
        set1.valueFont = UIFont.systemFont(ofSize: 10)
        set1.drawHighlightCircleEnabled = true
        set1.setDrawHighlightIndicators(false)
        
        let data: RadarChartData = [set1]
        data.setValueFont(.systemFont(ofSize: 8, weight: .medium))
        //data.setDrawValues(false)
        data.setValueTextColor(.futNight)
        radarChart.data = data
    }
}

#Preview {
    StatsActivity(player: Player(id: 1, firstName: "String", lastName: "String", photoUrl: nil, dateOfBirth: nil, playerId: 1, position: "String", shirtNumber: 41, nationality: nil), loading: .constant(false))
}
//Extensiones para realizar las medias
extension Array where Element: BinaryInteger {
    func average() -> Double {
        guard !isEmpty else { return 0 }
        let sum = Double(reduce(0, +))
        let avg = sum / Double(count)
        return (avg * 100).rounded() / 100
    }
    func sum() -> Int {
        let totalSum = self.reduce(0, +)
        return Int(totalSum)
    }
}

extension Array where Element: BinaryFloatingPoint {
    func average() -> Double {
        guard !isEmpty else { return 0 }
        let sum = Double(reduce(0, +))
        let avg = sum / Double(count)
        return (avg * 100).rounded() / 100
    }
    func sum() -> Int {
        let totalSum = self.reduce(0, +)
        return Int((totalSum * 100).rounded() / 100)
    }
}
