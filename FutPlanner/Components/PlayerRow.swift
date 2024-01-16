//
//  PlayerRow.swift
//  FutPlanner
//
//  Created by Pablo Rico alvarez on 16/1/24.
//

import SwiftUI

struct PlayerRow: View {
    
    var body: some View {
        HStack {
            Image(systemName: "person.fill").frame(width: 80, height: 80).font(.largeTitle).cornerRadius(8)
            VStack(alignment: .leading) {
                Text("Nombre apellidos")
                Text("Posicion: MC")
            }
            Spacer()
            Image(systemName: "arrowshape.forward.fill").font(.title3).padding()
        }.padding(4).background(Color.brown).cornerRadius(8)
    }
}

#Preview {
    PlayerRow()
}
