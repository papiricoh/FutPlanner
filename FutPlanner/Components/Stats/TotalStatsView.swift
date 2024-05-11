//
//  TotalStatsView.swift
//  FutPlanner
//
//  Created by Pablo Rico alvarez on 11/5/24.
//

import SwiftUI

struct TotalStatsView: View {
    var data: [Int]
    
    var body: some View {
        Divider()
        LazyVGrid (columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 10){
            VStack {
                Text("\(data[0])").font(.title3)
                Text("Evaluaciones")
            }
            VStack {
                Text("\(data[1])").font(.title3)
                Text("Partidos")
            }
            VStack {
                Text("\(data[0])").font(.title3)
                Text("Minutos totales")
            }
        }.font(.subheadline)
        Divider()
        LazyVGrid (columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 10){
            VStack {
                Text("\(data[3])").font(.title3)
                Text("Goles totales")
            }
            VStack {
                Text("\(data[4])").font(.title3)
                Text("Tajetas Rojas")
            }
            VStack {
                Text("\(data[5])").font(.title3)
                Text("Tajetas amarillas")
            }
        }.font(.subheadline)
    }
}

#Preview {
    TotalStatsView(data: [0, 1, 2, 3, 4, 5])
}
