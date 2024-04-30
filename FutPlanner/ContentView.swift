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
    @State public var logged = false
    @State public var loading = false
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor.futDay
        
    }
    
    var body: some View {
        ZStack() {
            if(!logged) {
                LogInView(onLoginSuccess: {
                    self.logged = true
                }, loading: $loading);
            }else {
                NavigationStack() {
                    TabView(selection:$selection) {
                        StatsTab(loading: $loading).tabItem {
                            Image(systemName: "chart.line.uptrend.xyaxis")
                            Text("Estadisticas")
                        }.tag(1)
                        HomeTab(onLogout: {
                            let defaults = UserDefaults.standard
                            defaults.set("", forKey: "token")
                            self.logged = false
                            user = nil
                        }, changeTab: { tab in
                            self.selection = tab
                        }, loading: $loading).tabItem {
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
        }.onAppear {
            fetchTokenUserContent()
        }
        
    }
    func fetchTokenUserContent() {
        loading = true
        Task {
            do {
                try await fetchTokenUser()
                if user != nil {
                    self.logged = true
                }
            } catch {
                print("Error en la solicitud: \(error.localizedDescription)")
            }
            loading = false
        }
    }

    
}

#Preview {
    ContentView()
}
