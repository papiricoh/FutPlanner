//
//  HomeTab.swift
//  FutPlanner
//
//  Created by Pablo Rico alvarez on 12/1/24.
//

import SwiftUI

struct HomeTab: View {
    var onLogout: () -> Void
    var body: some View {
        
        VStack() {
            Text("FutPlanner").font(.system(size: 30)).multilineTextAlignment(.leading).bold()
            ClubCard(onLogout: {
                self.onLogout()
            })
            ScrollView {
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
                
                NavigationLink(destination: MatchesView()) {
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
        }
    }
}

#Preview {
    HomeTab(onLogout: {
    })
}
