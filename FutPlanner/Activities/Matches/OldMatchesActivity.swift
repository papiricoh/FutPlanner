//
//  OldMatchesActivity.swift
//  FutPlanner
//
//  Created by Pablo Rico alvarez on 22/1/24.
//

import SwiftUI

struct OldMatchesActivity: View {
    var oldMatches: [fMatch]
    var body: some View {
        VStack {
            ScrollView {
                VStack  {
                    ForEach(oldMatches, id: \.id) { match in
                        NavigationLink(destination: MatchInfoActivity(infoMatch: match)) {
                            MatchOverview(match: match)
                        }
                    }
                }
            }
            Spacer()
        }.navigationBarTitle("Antiguos partidos", displayMode: .inline)
    }
}

#Preview {
    OldMatchesActivity(oldMatches: [fMatch(id: 1, homeTeamName: "", awayTeamName: "", category: "", subCategory: "", you: 2, date: Date(), coordinates_name: "", evaluated: true, coordinates: Coordinates(latitude: 0, longitude: 0), homeTeamId: 2, awayTeamId: nil)])
}
