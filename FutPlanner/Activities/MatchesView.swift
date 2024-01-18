//
//  MatchesView.swift
//  FutPlanner
//
//  Created by Pablo Rico alvarez on 15/1/24.
//

import SwiftUI

struct MatchesView: View {
    @State private var showCreateMatchSheet = false
    
    var body: some View {
        VStack {
            HStack {
                Text("Gestion de partidos").font(.title2).bold()
                Spacer()
                Button(action: {self.showCreateMatchSheet = !self.showCreateMatchSheet}, label: {
                    Image(systemName: "plus.circle.fill").font(.largeTitle)
                })
            }.padding()
            if(self.showCreateMatchSheet) {
                
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
        }.navigationBarTitle("Proximos partidos", displayMode: .inline).animation(.default, value: showCreateMatchSheet).sheet(isPresented: $showCreateMatchSheet) {
            CreateMatchSheetView().presentationDetents([.medium, .large])
        }
    }
}

#Preview {
    MatchesView()
}
