//
//  OldMatchesActivity.swift
//  FutPlanner
//
//  Created by Pablo Rico alvarez on 22/1/24.
//

import SwiftUI

struct OldMatchesActivity: View {
    var oldMatches: [MatchInfo]
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
    OldMatchesActivity(oldMatches: matches)
}
