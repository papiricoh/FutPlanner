//
//  ReportRow.swift
//  FutPlanner
//
//  Created by Pablo Rico alvarez on 13/5/24.
//

import SwiftUI

struct ReportRow: View {
    @State var isDataOpen: Bool = false
    @State var report: Report
    
    var body: some View {
        VStack {
            Button(action: {
                self.isDataOpen = !self.isDataOpen
            }, label: {
                HStack {
                    Text("\(report.match.homeTeamName) - \(report.match.awayTeamName)")
                    Spacer()
                    Text("\(convertDate(report.match.matchDate) ?? "?")")
                    Image(systemName: "arrowshape.forward.fill").font(.title3).padding().rotationEffect(.degrees(isDataOpen ? 90 : 0))
                }.bold()
            })
            if(isDataOpen) {
                Divider()
                LazyVGrid (columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 10){
                    VStack {
                        Text("\(report.generalPerformance)").font(.title3)
                        Text("General")
                    }
                    VStack {
                        Text("\(report.tacticalPerformance)").font(.title3)
                        Text("Tactico")
                    }
                    VStack {
                        Text("\(report.passesQuality)").font(.title3)
                        Text("Pases")
                    }
                    VStack {
                        Text("\(report.ballControl)").font(.title3)
                        Text("Control")
                    }
                    VStack {
                        Text("\(report.gameVision)").font(.title3)
                        Text("Vision")
                    }
                }.font(.subheadline)
                Divider()
                LazyVGrid (columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 10){
                    VStack {
                        Text("\(report.goals)").font(.title3)
                        Text("Goles")
                    }
                    VStack {
                        Text("\(report.playedTime)").font(.title3)
                        Text("Minutos")
                    }
                    VStack {
                        Text("\(report.yellowCards)").font(.title3)
                        Text("Amarillas")
                    }
                    VStack {
                        Text("\(report.redCards)").font(.title3)
                        Text("Rojas")
                    }
                }.font(.subheadline)
            }
        }.padding().overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.futGreen, lineWidth: 2)
        ).padding().animation(.interactiveSpring, value: isDataOpen)
    }
    
    
    func convertDate(_ sqlDate: String) -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        inputFormatter.timeZone = TimeZone(secondsFromGMT: 0)

        guard let date = inputFormatter.date(from: sqlDate) else {
            print("Invalid date format")
            return nil
        }

        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "dd-MM-yyyy"

        return outputFormatter.string(from: date)
    }
}

#Preview {
    ReportRow(report: Report(id: 1, playerId: 1, matchId: 1, generalPerformance: 5, tacticalPerformance: 4, passesQuality: 3, ballControl: 6, gameVision: 3, playedTime: 29, goals: 2, redCards: 0, yellowCards: 1, match: Match(id: 1, matchDate: "2023-05-13T15:45:00.000Z", mapCoords: "2032,313", placeName: "Asturias", homeTeamId: 1, homeTeamName: "Lopezines", awayTeamId: 3, awayTeamName: "Test", subCategoryId: 1, evaluated: 1)))
}
