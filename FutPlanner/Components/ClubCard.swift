//
//  ClubCard.swift
//  FutPlanner
//
//  Created by Pablo Rico alvarez on 14/1/24.
//

import SwiftUI

struct ClubCard: View {
    var body: some View {
        HStack() {
            Image("ClubPlaceholder").resizable().frame(width: 80.0, height: 80.0)
                .clipShape(Circle())
            VStack(alignment: .leading) {
                Text("Nombre del club")
                Text("Nombre de tu equipo")
            }
            Spacer()
            Button(action: {}, label: {
                VStack {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                    Text("Salir").multilineTextAlignment(.center)
                }
            })
        }.padding().overlay(Rectangle().frame(height: 2).foregroundColor(.gray), alignment: .bottom)
    }
}

#Preview {
    ClubCard()
}
