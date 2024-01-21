//
//  BottomSheetView.swift
//  FutPlanner
//
//  Created by Pablo Rico alvarez on 18/1/24.
//

import SwiftUI
import MapKit

struct CreateMatchSheetView: View {
    @State private var rivalTeamName: String = ""
    @State private var isHomeTeam: Bool = true
    @State private var date: Date = Date()
    @State private var searchText: String = ""
    @State private var searchMode: Bool = false
    @ObservedObject private var searchService = LocationSearchService()
    @State private var coords: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    @State private var region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
            latitudinalMeters: 1000,
            longitudinalMeters: 1000
        )
    @State private var selectedPlace: String = "Sin ubicacion"
    var showingSheet: () -> Void

    
    
    @State private var coordinates = CLLocationCoordinate2D(latitude: 43.359496, longitude: -5.8653342)

    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Text("Añade un partido").bold().font(.title2)
                Spacer()
                Button(action: {
                    ///TODO: Llamar a la API para insertar el partido
                    var homeTeam = team.team_name
                    var awayTeam = self.rivalTeamName
                    if(!isHomeTeam) {
                        homeTeam = self.rivalTeamName
                        awayTeam = team.team_name
                    }
                    let newMatch = MatchInfo(id: matches.count + 1, homeTeamName: homeTeam, awayTeamName: awayTeam, category: team.category, subCategory: team.subCategory, date: self.date, coordinates: Coordinates(latitude: region.center.latitude, longitude: region.center.longitude))
                    matches.append(newMatch)
                    self.showingSheet()
                }) {
                    Text("Añadir").bold()
                }
            }.padding(.horizontal)
            Divider()
            ScrollView{
                VStack(spacing: 30) {
                    HStack {
                        Image(systemName: "shield.lefthalf.filled")
                        TextField("Nombre del rival", text: $rivalTeamName)
                    }.cornerRadius(20).padding().overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.blue, lineWidth: 5)
                    )
                    Toggle("Tu equipo juega en casa?", isOn: $isHomeTeam).toggleStyle(SwitchToggleStyle(tint: Color.futGreen))
                    DatePicker(
                        "Comienzo del partido",
                        selection: $date,
                        displayedComponents: [.date, .hourAndMinute]
                    )
                    VStack {
                        HStack {
                            Image(systemName: "sportscourt")
                            TextField("Nombre del campo", text: $searchText).onChange(of: searchText) {
                                searchService.search(query: searchText)
                            }
                            Button(action: {self.searchMode = !self.searchMode}) {
                                Text("Buscar")
                            }
                        }
                        ForEach(searchService.searchResults, id: \.self) { result in
                            if(!self.searchText.isEmpty) {
                                Text(result.title).onTapGesture {
                                    selectedPlace = result.title
                                    searchService.getCoordinates(for: result) { coordinate in
                                        if let coordinate = coordinate {
                                            self.searchText = ""
                                            self.coords = coordinate
                                            self.region.center = coordinate
                                        } else {
                                            print("No se pudo obtener las coordenadas")
                                        }
                                    }
                                }
                            }
                        }
                    }.padding().overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.futGreen, lineWidth: 5)
                    )
                    ZStack {
                        Map(coordinateRegion: $region, showsUserLocation: true).frame(height: 300).cornerRadius(20)
                        Text(selectedPlace).bold().padding().background(Color.futGreen).cornerRadius(20).foregroundStyle(Color.white).offset(y: -120)
                    }
                    
                }.padding()
            }
            
            Spacer()
        }.padding(.top, 30).animation(.default, value: searchText)
    }

}


#Preview {
    CreateMatchSheetView(showingSheet: {})
}
