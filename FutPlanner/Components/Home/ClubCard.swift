//
//  ClubCard.swift
//  FutPlanner
//
//  Created by Pablo Rico alvarez on 14/1/24.
//

import SwiftUI

struct ClubCard: View {
    var onLogout: () -> Void
    var team: TeamData
    var body: some View {
        HStack() {
            AsyncImage(url: URL(string: team.shield_url)){ image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }.frame(width: 80.0, height: 80.0)
                .clipShape(Rectangle()).cornerRadius(10)
            
            VStack(alignment: .leading) {
                Text(team.club_name).bold().font(.title3)
                Text(team.team_name)
            }
            Spacer()
            Button(action: onLogout, label: {
                VStack {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                    Text("Salir").multilineTextAlignment(.center)
                }
            })
        }.padding().overlay(Rectangle().frame(height: 2).foregroundColor(.gray), alignment: .bottom)
    }
}

#Preview {
    ClubCard(onLogout: {
        
    }, team: team)
}
