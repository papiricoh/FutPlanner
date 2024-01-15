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
    @Query private var items: [Item]
    @State private var selection = 2

    var body: some View {
        VStack {
            NavigationView() {
                TabView(selection:$selection) {
                    Text("Stadistics").tabItem {
                        Image(systemName: "chart.line.uptrend.xyaxis")
                        Text("Evaluaciones")
                    }.tag(1)
                    HomeTab().tabItem {
                        Image(systemName: "soccerball")
                        Text("Principal")
                    }.tag(2)
                    Text("Team").tabItem {
                        Image(systemName: "sportscourt")
                        Text("Equipo")
                    }.tag(3)
                }
            }
        }
        
        
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
