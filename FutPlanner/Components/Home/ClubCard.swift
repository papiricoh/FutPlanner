//
//  ClubCard.swift
//  FutPlanner
//
//  Created by Pablo Rico alvarez on 14/1/24.
//

import SwiftUI

struct ClubCard: View {
    var onLogout: () -> Void
    var team: Team
    var body: some View {
        HStack() {
            AsyncImage(url: URL(string: team.club.shieldUrl ?? "https://st3.depositphotos.com/6672868/13701/v/450/depositphotos_137014128-stock-illustration-user-profile-icon.jpg")){ image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }.frame(width: 80.0, height: 80.0)
                .clipShape(Rectangle()).cornerRadius(10)
            
            VStack(alignment: .leading) {
                Text(team.club.clubName).bold().font(.title3)
                Text(team.teamName)
            }
            Spacer()
            Button(action: onLogout, label: {
                VStack {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                    Text("Salir").multilineTextAlignment(.center)
                }
            })
        }.padding().overlay(Rectangle().frame(height: 1).foregroundColor(.gray), alignment: .bottom)
    }
}

#Preview {
    ClubCard(onLogout: {
        
    }, team: Team(id: 1, teamName: "String", shieldUrl: nil, subCategoryId: 1, clubId: 1, players: nil, club: Club(id: 1, clubName: "String", shieldUrl: nil, ownerId: 3)))
}
