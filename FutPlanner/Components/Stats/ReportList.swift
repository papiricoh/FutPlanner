//
//  ReportList.swift
//  FutPlanner
//
//  Created by Pablo Rico alvarez on 13/5/24.
//

import SwiftUI

struct ReportList: View {
    @State var reports: [Report]
    
    var body: some View {
        ForEach(reports) { report in
            ReportRow(report: report)
        }
    }
}

#Preview {
    ReportList(reports: [Report(id: 1, playerId: 1, matchId: 1, generalPerformance: 5, tacticalPerformance: 4, passesQuality: 3, ballControl: 6, gameVision: 3, playedTime: 29, goals: 2, redCards: 0, yellowCards: 1, match: Match(id: 1, matchDate: "2023-05-13T15:45:00.000Z", mapCoords: "2032,313", placeName: "Asturias", homeTeamId: 1, homeTeamName: "Lopezines", awayTeamId: 3, awayTeamName: "Test", subCategoryId: 1, evaluated: 1))])
}
