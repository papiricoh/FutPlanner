//
//  HomeTab.swift
//  FutPlanner
//
//  Created by Pablo Rico alvarez on 12/1/24.
//

import SwiftUI

struct HomeTab: View {
    var onLogout: () -> Void
    @State private var loaded = false
    @State private var lastMatch: MatchInfo? = matches[0]   //Debug set to nil
    @State private var nextMatch: MatchInfo? = matches[1]
    var changeTab: (Int) -> Void
    var body: some View {
        
        VStack() {
            Text("FutPlanner").font(.system(size: 30)).multilineTextAlignment(.leading).bold()
            Divider()
            ClubCard(onLogout: {
                //self.lastMatch = nil
                self.onLogout()
            })
            ScrollView {
                if(nextMatch != nil) {
                    NextMatchComponent(match: nextMatch!)
                }
                if(lastMatch != nil && lastMatch?.evaluated == false) {
                    NavigationLink(destination: ReportEvaluator(players: team.players, match: lastMatch!)) {
                        HStack {
                            Image(systemName: "exclamationmark.octagon.fill").foregroundColor(.yellow).font(.system(size: 80))
                            Spacer()
                            VStack(alignment: .trailing) {
                                Text("Partido sin evaluar").font(.system(size: 24)).bold()
                                Text("\(lastMatch?.homeTeamName ?? "") - \(lastMatch?.awayTeamName ?? "")")
                                Text("\(formatDate(lastMatch?.date ?? Date()))")
                            }.foregroundColor(.futDay)
                        }.padding().background(Color.futNight.opacity(0.8)).cornerRadius(10).padding(4)
                    }
                }
                NavigationLink(destination: MatchesView()) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Partidos").font(.system(size: 20)).bold()
                            Text("Organiza tus siguientes partidos desde este apartado").multilineTextAlignment(.leading)
                        }
                        Spacer()
                        Image(systemName: "arrowshape.forward.fill")
                    }.padding().background(Color("FutGreen")).cornerRadius(10).foregroundColor(Color.white).padding(4)
                }
                
                Button(action: {changeTab(1)}) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Sesiones/Evaluaciones").font(.system(size: 20)).bold()
                            Text("Evalua el desempeño de tus jugadores por sesiones realizadas").multilineTextAlignment(.leading)
                        }
                        Spacer()
                        Image(systemName: "arrowshape.forward.fill")
                    }
                    .padding()
                    .background(Color("FutGreen")).cornerRadius(10)
                    .foregroundColor(Color.white).padding(4)
                }
            }
            
        }.padding(.top, 10).offset(x: 0, y: self.loaded ? 0 : -UIScreen.main.bounds.height)
            .animation(Animation.spring().delay(0.5), value: self.loaded)
            .onAppear {
                self.loaded = true
                //Todo redo fetch
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
    HomeTab(onLogout: {
    }, changeTab: {tab in})
}
