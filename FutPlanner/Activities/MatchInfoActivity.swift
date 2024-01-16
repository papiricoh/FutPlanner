//
//  MatchInfoActivity.swift
//  FutPlanner
//
//  Created by Pablo Rico alvarez on 16/1/24.
//

import SwiftUI
import MapKit

struct MatchInfoActivity: View {
    let infoMatch: MatchInfo
    @State var loaded = false
    
    var body: some View {
        VStack {
            Map(initialPosition: .region(region)).frame(height: 500)
            VStack {
                HStack {
                    VStack {
                        Image("teamPlaceholder").resizable().frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100).clipShape(Circle())
                            .overlay {
                                Circle().stroke(.white, lineWidth: 4)
                            }.shadow(radius: 3)
                        Text(infoMatch.homeTeamName).bold().font(.headline)
                    }.padding().frame(width: 150).background(Color("NightColor")).cornerRadius(10).offset(y: -100)
                    Text("VS").padding().background(Color("NightColor")).cornerRadius(10).offset(y: -100).font(.system(size: 8))
                    VStack {
                        Image("teamPlaceholder").resizable().frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100).clipShape(Circle())
                            .overlay {
                                Circle().stroke(.white, lineWidth: 4)
                            }.shadow(radius: 3)
                        Text(infoMatch.awayTeamName).bold().font(.headline)
                    }.padding().frame(width: 150).background(Color("NightColor")).cornerRadius(10).offset(y: -100)
                }.padding().padding(.bottom, -110)
                Divider()
                HStack {
                    VStack(alignment: .leading) {
                        Text("Categoria").bold().font(.title3)
                        Text(infoMatch.category + " - " + infoMatch.subCategory)
                    }
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text("Fecha").bold().font(.title3)
                        Text(formatDate(infoMatch.date))
                    }
                }.padding()
            }.offset(x: 0, y: self.loaded ? 0 : UIScreen.main.bounds.height)
                .animation(Animation.spring().delay(0.5), value: self.loaded)
                .onAppear {
                self.loaded = true
                }
            Spacer()
        }.navigationTitle(infoMatch.homeTeamName + " - " + infoMatch.awayTeamName)
    }
    
    private var region: MKCoordinateRegion {
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: infoMatch.coordinates.latitude, longitude: infoMatch.coordinates.longitude),
            span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        )
    }
    
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.locale = Locale(identifier: "es_ES")

        return formatter.string(from: date)
    }
}

#Preview {
    MatchInfoActivity(infoMatch: matches[0])
}
