//
//  NextMatchComponent.swift
//  FutPlanner
//
//  Created by Pablo Rico alvarez on 5/3/24.
//

import SwiftUI

struct NextMatchComponent: View {
    var match: MatchInfo
    var body: some View {
        VStack(alignment: .leading){
            Text("Siguiente Partido").bold().font(.system(size: 24))
            HStack {
                Text("\(match.homeTeamName)")
                Spacer()
                Text(" - ")
                Spacer()
                Text("\(match.awayTeamName)")
            }.bold().font(.title3)
            HStack {
                Text("\(formatDate(match.date))")
                Spacer()
                Text("\(timeRemaining(match.date))")
            }
            NavigationLink(destination: MatchInfoActivity(infoMatch: match)) {
                HStack(alignment: .center) {
                    Spacer()
                    Text("Ver Partido").foregroundColor(.futNight).bold()
                    Spacer()
                }.padding().background(Color.futNight.opacity(0.2)).cornerRadius(10).padding(4)
            }
        }.padding().background(Color.futNight.opacity(0.2)).cornerRadius(10).padding(4)
    }
    
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        formatter.locale = Locale(identifier: "es_ES")

        return formatter.string(from: date)
    }
    
    func timeRemaining(_ futureDate: Date) -> String {
        
        let currentDate = Date()
        let calendar = Calendar.current
        
        let components = calendar.dateComponents([.day, .hour], from: currentDate, to: futureDate)
        
        let days = components.day ?? 0
        let hours = components.hour ?? 0
        
        return "\(days) días y \(hours) horas restantes"
    }
}

#Preview {
    NextMatchComponent(match: matches[1])
}
