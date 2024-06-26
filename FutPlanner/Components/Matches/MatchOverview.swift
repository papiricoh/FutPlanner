//
//  MatchOverview.swift
//  FutPlanner
//
//  Created by Pablo Rico alvarez on 15/1/24.
//

import SwiftUI

struct MatchOverview: View {
    var match: fMatch
    @State private var loaded = false
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(match.homeTeamName) - \(match.awayTeamName)").bold().font(.title3)
                Text("\(match.category) \(match.subCategory)")
                Text(formatDate(match.date))
            }
            Spacer()
            Image(systemName: "play.fill")
        }.padding(8).background(Color.futGreen).cornerRadius(10).foregroundColor(.white).padding(4).offset(x: self.loaded ? 0 : UIScreen.main.bounds.width, y: 0)
            .animation(Animation.spring().delay(0.5), value: self.loaded)
            .onAppear {
            self.loaded = true
            }
        
    }
    
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.locale = Locale(identifier: "es_ES")

        return formatter.string(from: date)
    }
}

#Preview {
    MatchOverview(match: fMatch(id: 1, homeTeamName: "", awayTeamName: "", category: "", subCategory: "", you: 2, date: Date(), coordinates_name: "", evaluated: true, coordinates: Coordinates(latitude: 0, longitude: 0), homeTeamId: 2, awayTeamId: nil))
}
