//
//  StatsActivity.swift
//  FutPlanner
//
//  Created by Pablo Rico alvarez on 23/1/24.
//

import SwiftUI
import DGCharts

struct StatsActivity: View {
    var player: Player
    
    
    var body: some View {
        VStack {
            Text(player.first_name + " " + player.last_name).bold().font(.title2)
            Divider()
            ScrollView {
                VStack {
                    RadarChartRepresentable().frame(height: 400)
                    Divider()
                    VStack() {
                        Text("Medias y totales")
                        HStack() {
                            HStack {
                                Image(systemName: "soccerball").font(.title)
                                Text("9 Goles").bold()
                            }.padding(.horizontal, 10).padding().frame(height:80).frame(width: 160).background(Color.futBlue).cornerRadius(10).padding(.horizontal, 20)
                            Spacer()
                            HStack {
                                Image(systemName: "checkmark.gobackward").font(.title)
                                Text("42.3 Minutos").bold()
                            }.padding(.horizontal, 10).padding().frame(height: 80).frame(width: 160).background(Color.futBlue).cornerRadius(10).padding(.horizontal, 20)
                        }
                        HStack() {
                            HStack {
                                Image(systemName: "greetingcard.fill").font(.title).foregroundStyle(Color.yellow)
                                Text("6 Tarjetas").bold()
                            }.padding(.horizontal, 10).padding().frame(height:80).frame(width: 160).background(Color.futBlue).cornerRadius(10).padding(.horizontal, 20)
                            Spacer()
                            HStack {
                                Image(systemName: "greetingcard.fill").font(.title).foregroundStyle(Color.futRed)
                                Text("3 Tarjetas").bold()
                            }.padding(.horizontal, 10).padding().frame(height:80).frame(width: 160).background(Color.futBlue).cornerRadius(10).padding(.horizontal, 20)
                        }
                    }
                    Divider()
                    VStack {
                        
                    }
                    Spacer()
                }
            }
            Spacer()
        }.padding(.top, 10).navigationBarTitle("Estadisticas de " + player.first_name, displayMode: .inline)
    }
}
struct RadarChartRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> RadarChartViewController {
        return RadarChartViewController()
    }

    func updateUIViewController(_ uiViewController: RadarChartViewController, context: Context) {
    }
}

class RadarChartViewController: UIViewController {
    var radarChart: RadarChartView!

    override func viewDidLoad() {
        super.viewDidLoad()
        radarChart = RadarChartView(frame: self.view.bounds)
        radarChart.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        radarChart.rotationEnabled = false
        radarChart.yAxis.drawLabelsEnabled = false
        radarChart.legend.enabled = false
        
        setupRadarChart()
        self.view.addSubview(radarChart)
    }

    func setupRadarChart() {
        let mult: UInt32 = 80
        let min: UInt32 = 20
        let cnt = 5
        
        let categories = ["Desempeño \nGeneral", "Desempeño \nTactico", "Pases", "Control\nBalon", "Vision\nde juego"]
        
        radarChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: categories)
        radarChart.xAxis.labelTextColor = .futNight // Configura el color según necesites
        radarChart.xAxis.labelFont = .systemFont(ofSize: 12, weight: .bold)
        
        let block: (Int) -> RadarChartDataEntry = { _ in return RadarChartDataEntry(value: Double(arc4random_uniform(mult) + min))}
        let entries1 = (0..<cnt).map(block)
        
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
    StatsActivity(player: team.players[0])
}
