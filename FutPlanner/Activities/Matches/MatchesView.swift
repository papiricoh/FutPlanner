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
    @State private var avariable: [fMatch] = []
    
    var body: some View {
        VStack {
            if(!loading) {
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
                        ForEach(self.avariable, id: \.id) { match in
                            NavigationLink(destination: MatchInfoActivity(infoMatch: match)) {
                                MatchOverview(match: match)
                            }
                        }
                        if(self.avariable.isEmpty) {
                            Spacer()
                            Text("No hay partidos pendientes")
                        }
                    }
                }
                Spacer()
            }
        }.navigationBarTitle("Proximos partidos", displayMode: .inline).animation(.default, value: showCreateMatchSheet).sheet(isPresented: $showCreateMatchSheet) {
            CreateMatchSheetView() { 
                self.showCreateMatchSheet = !self.showCreateMatchSheet
            }.presentationDetents([.medium, .large])
        }.onAppear () {
            loading = true
            Task {
                do {
                    try await fetchMatches()
                    self.avariable = avariableMatches();
                    loading = false
                } catch {
                    print("Error en la solicitud: \(error.localizedDescription)")
                    loading = false
                }
            }
        }
    }
    func avariableMatches() -> [fMatch] {
        var newMatches: [fMatch] = []
        for match in fMatches ?? [] {
            if match.date >= Date() {
                newMatches.append(match)
            }
        }
        
        return newMatches.sorted { $0.date < $1.date }
    }
    
    func unavariableMatches() -> [fMatch] {
        var newMatches: [fMatch] = []
        for match in fMatches ?? [] {
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
