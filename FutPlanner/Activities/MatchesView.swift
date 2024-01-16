//
//  MatchesView.swift
//  FutPlanner
//
//  Created by Pablo Rico alvarez on 15/1/24.
//

import SwiftUI

struct MatchesView: View {
    @State var addMode = false
    
    var body: some View {
        VStack {
            HStack {
                Text("Gestion de partidos").font(.title2).bold()
                Spacer()
                Button(action: {self.addMode = !self.addMode}, label: {
                    Image(systemName: "plus.circle.fill").font(.largeTitle)
                })
            }.padding()
            if(self.addMode) {
                
            }
            ScrollView {
                VStack  {
                    ForEach(matches, id: \.id) { match in
                        NavigationLink(destination: MatchInfoActivity(infoMatch: match)) {
                            MatchOverview(match: match)
                        }
                    }
                }
            }
            Spacer()
        }.navigationBarTitle("Proximos partidos", displayMode: .inline).animation(.default, value: addMode)
    }
}

#Preview {
    MatchesView()
}
