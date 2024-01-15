//
//  MatchesView.swift
//  FutPlanner
//
//  Created by Pablo Rico alvarez on 15/1/24.
//

import SwiftUI

struct MatchesView: View {
    
    var body: some View {
        VStack {
            HStack {
                Text("Gestion de partidos").font(.title2).bold()
                Spacer()
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Image(systemName: "plus.circle.fill").font(.largeTitle)
                })
            }.padding()
            
            ScrollView {
                VStack  {
                    ForEach(matches, id: \.id) { match in
                        NavigationLink(destination: {}) {
                            MatchOverview(match: match)
                        }
                    }
                }
            }
            Spacer()
        }.navigationBarTitle("Proximos partidos", displayMode: .inline)
    }
}

#Preview {
    MatchesView()
}
