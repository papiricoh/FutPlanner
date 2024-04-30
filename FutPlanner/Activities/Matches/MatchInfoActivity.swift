//
//  MatchInfoActivity.swift
//  FutPlanner
//
//  Created by Pablo Rico alvarez on 16/1/24.
//

import SwiftUI
import MapKit

struct MatchInfoActivity: View {
    let infoMatch: fMatch
    @State var loaded = false
    
    var body: some View {
        VStack {
            ZStack {
                Map(initialPosition: .region(region)) {
                    Annotation(infoMatch.coordinates_name, coordinate: region.center) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 5)
                                .fill(Color.futGreenLight)
                            Text("🥅")
                                .padding(5)
                        }
                    }
                }.frame(height: 500)
            }
            VStack {
                HStack {
                    ZStack {
                        VStack {
                            Image("teamPlaceholder").resizable().frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100).clipShape(Circle())
                                .overlay {
                                    Circle().stroke(.white, lineWidth: 4)
                                }.shadow(radius: 3)
                            Text(infoMatch.homeTeamName).bold().font(.headline)
                        }
                        if(infoMatch.you == 0) {
                            Text("Tu").bold().rotationEffect(Angle(degrees: 45)).offset(x:55, y:-60).shadow(radius: 4).foregroundStyle(Color.futGold)
                        }
                    }.padding().frame(width: 150).background(Color("NightColor")).cornerRadius(10).overlay(infoMatch.you == 0 ? RoundedRectangle(cornerRadius: 10).stroke(Color.futGold, lineWidth: 2) : nil).offset(y: -100)
                    Text("VS").padding().background(Color("NightColor")).cornerRadius(10).offset(y: -100).font(.system(size: 8))
                    ZStack {
                        VStack {
                            Image("teamPlaceholder").resizable().frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100).clipShape(Circle())
                                .overlay {
                                    Circle().stroke(.white, lineWidth: 4)
                                }.shadow(radius: 3)
                            Text(infoMatch.awayTeamName).bold().font(.headline)
                        }
                        if(infoMatch.you == 1) {
                            Text("Tu").bold().rotationEffect(Angle(degrees: -45)).offset(x:-55, y:-60).shadow(radius: 4).foregroundStyle(Color.futGold)
                        }
                    }.padding().frame(width: 150).background(Color("NightColor")).cornerRadius(10).overlay(infoMatch.you == 1 ? RoundedRectangle(cornerRadius: 10).stroke(Color.futGold, lineWidth: 2) : nil).offset(y: -100)
                }.padding().padding(.bottom, -110).foregroundStyle(Color.futNight)
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
                Spacer()
            }.background(Color.futGreen).offset(x: 0, y: self.loaded ? 0 : UIScreen.main.bounds.height)
                .animation(Animation.spring().delay(0.5), value: self.loaded)
                .onAppear {
                self.loaded = true
                }
        }.navigationTitle(infoMatch.homeTeamName + " - " + infoMatch.awayTeamName).foregroundStyle(Color.white)
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
    MatchInfoActivity(infoMatch: fMatch(id: 1, homeTeamName: "", awayTeamName: "", category: "", subCategory: "", you: 2, date: Date(), coordinates_name: "", evaluated: true, coordinates: Coordinates(latitude: 0, longitude: 0), homeTeamId: 2))
}
