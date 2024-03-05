//
//  ContentView.swift
//  FutPlanner
//
//  Created by Pablo Rico alvarez on 5/10/23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var selection = 2
    @State public var logged = true
    @State public var loading = false
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor.white
    }
    
    var body: some View {
        ZStack() {
            if(!logged) {
                LogInView(onLoginSuccess: {
                    self.logged = true
                });
            }else {
                NavigationStack() {
                    TabView(selection:$selection) {
                        StatsTab().tabItem {
                            Image(systemName: "chart.line.uptrend.xyaxis")
                            Text("Estadisticas")
                        }.tag(1)
                        HomeTab(onLogout: {
                            self.logged = false
                        }, changeTab: { tab in
                            self.selection = tab
                        }).tabItem {
                            Image(systemName: "soccerball")
                            Text("Principal")
                        }.tag(2)
                        TeamTab().tabItem {
                            Image(systemName: "sportscourt")
                            Text("Equipo")
                        }.tag(3)
                    }
                }
            }
            if(loading) {
                LoadingComponent()
            }
        }
        
    }

    
}

#Preview {
    ContentView()
}
