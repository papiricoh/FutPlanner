//
//  MatchesView.swift
//  FutPlanner
//
//  Created by Pablo Rico alvarez on 15/1/24.
//

import SwiftUI

struct MatchesView: View {
    @State private var showCreateMatchSheet = false
    @Binding var loading: Bool
    
    var body: some View {
        VStack {
            HStack {
                Text("Gestion de partidos").font(.title2).bold()
                Spacer()
                Button(action: {self.showCreateMatchSheet = !self.showCreateMatchSheet}, label: {
                    Image(systemName: "plus.circle.fill").font(.largeTitle)
                })
            }.padding()
            ScrollView {
                VStack  {
                    NavigationLink(destination: {OldMatchesActivity(oldMatches: self.unavariableMatches())}) {
                        HStack(){
                            Text("Completados")
                            Image(systemName: "trophy.fill")
                        }
                    }.frame(width: UIScreen.main.bounds.width).padding(.vertical).background(Color.futGreenDark).foregroundColor(.white).bold()
                    ForEach(self.avariableMatches(), id: \.id) { match in
                        NavigationLink(destination: MatchInfoActivity(infoMatch: match)) {
                            MatchOverview(match: match)
                        }
                    }
                }
            }
            Spacer()
        }.navigationBarTitle("Proximos partidos", displayMode: .inline).animation(.default, value: showCreateMatchSheet).sheet(isPresented: $showCreateMatchSheet) {
            CreateMatchSheetView() { 
                self.showCreateMatchSheet = !self.showCreateMatchSheet
            }.presentationDetents([.medium, .large])
        }.onAppear () {
            loading = true
            Task {
                do {
                    try await fetchMatches()
                    
                    loading = false
                } catch {
                    print("Error en la solicitud: \(error.localizedDescription)")
                    loading = false
                }
            }
        }
    }
    func avariableMatches() -> [MatchInfo] {
        var newMatches: [MatchInfo] = []
        for match in matches {
            if match.date >= Date() {
                newMatches.append(match)
            }
        }
        
        return newMatches.sorted { $0.date < $1.date }
    }
    
    func unavariableMatches() -> [MatchInfo] {
        var newMatches: [MatchInfo] = []
        for match in matches {
            if match.date < Date() {
                newMatches.append(match)
            }
        }
        
        return newMatches.sorted { $0.date < $1.date }
    }
}

#Preview {
    MatchesView(loading: .constant(false))
}
