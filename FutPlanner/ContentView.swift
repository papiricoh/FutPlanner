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

    var body: some View {
        VStack {
            TabView {
                HomeTab().tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                Text("profile").tabItem {
                    Image(systemName: "person.fill")
                    Text("profile")
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
