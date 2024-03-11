//
//  ProfileCard.swift
//  FutPlanner
//
//  Created by Pablo Rico alvarez on 26/2/24.
//

import SwiftUI

struct ProfileCard: View {
    
    var player: TPlayer
    
    var body: some View {
        VStack{
            HStack(alignment: .top) {
                Text(player.first_name + " " + player.last_name).textCase(.uppercase).font(.title2).bold()
                Spacer()
                AsyncImage(url: URL(string: player.photo_url)){ image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }.frame(width: 100, height: 100).cornerRadius(16)
            }
            HStack(spacing: 10) {
                VStack(alignment: .center) {
                    Text("Posicion").font(.caption2)
                    Text(player.position).bold()
                }
                Divider().frame(width: 1, height: 50)
                VStack(alignment: .center) {
                    Text("Pais").font(.caption2)
                    Text(player.nationality).bold()
                }
                Divider().frame(width: 1, height: 50)
                VStack(alignment: .center) {
                    Text("Numero").font(.caption2)
                    Text(String(player.shirt_number)).bold()
                }
                Divider().frame(width: 1, height: 50)
                VStack(alignment: .center) {
                    Text("Nacimiento").font(.caption2)
                    Text(formatDate(player.date_of_birth)).bold()
                }
            }
        }.padding().overlay(RoundedRectangle(cornerRadius: 16).stroke(.futNight, lineWidth: 3)).padding(.horizontal)
    }
    
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        formatter.locale = Locale(identifier: "es_ES")

        return formatter.string(from: date)
    }
}

#Preview {
    ProfileCard(player: team.players[0])
}
