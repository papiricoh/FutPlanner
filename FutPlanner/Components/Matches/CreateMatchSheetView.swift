//
//  BottomSheetView.swift
//  FutPlanner
//
//  Created by Pablo Rico alvarez on 18/1/24.
//

import SwiftUI
import MapKit
import Alamofire

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
    @Binding var loading: Bool

    
    
    @State private var coordinates = CLLocationCoordinate2D(latitude: 43.359496, longitude: -5.8653342)

    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Text("Añade un partido").bold().font(.title2)
                Spacer()
                Button(action: {
                    
                    Task {
                        do {
                            loading = true
                            
                            var homeTeam = fTeam!.teamName
                            var awayTeam = self.rivalTeamName
                            if(!isHomeTeam) {
                                homeTeam = self.rivalTeamName
                                awayTeam = fTeam!.teamName
                            }
                            
                            var newMatch = fMatch(id: 1, homeTeamName: homeTeam, awayTeamName: awayTeam, category: team.category, subCategory: team.subCategory, you: self.isHomeTeam ? 0: 1, date: self.date, coordinates_name: selectedPlace, evaluated: false, coordinates: Coordinates(latitude: region.center.latitude, longitude: region.center.longitude), homeTeamId: self.isHomeTeam ? fTeam!.id : nil, awayTeamId: !self.isHomeTeam ? fTeam!.id : nil)
                            
                            
                            if(fMatches == nil) {
                                fMatches = []
                            }
                            
                            
                            
                            ///TODO: Llamar a la API para insertar el partido
                            let id = try await insertMatch(newMatch)
                            
                            newMatch.id = id
                            fMatches!.append(newMatch)
                            loading = false
                            self.showingSheet()
                        } catch {
                            print("Error en la solicitud: \(error.localizedDescription)")
                            loading = false
                        }
                    }
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
                        }
                        ForEach(searchService.searchResults, id: \.self) { result in
                            if(!self.searchText.isEmpty) {
                                PlaceListItem(text: result.title).simultaneousGesture(
                                    TapGesture()
                                        .onEnded {
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
                                })
                            }
                        }
                    }.padding().overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.futGreen, lineWidth: 5)
                    )
                    ZStack {
                        Map() {
                            Annotation(self.selectedPlace, coordinate: region.center) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 5)
                                        .fill(Color.futGreenLight)
                                    Text("🥅")
                                        .padding(5)
                                }
                            }
                        }.frame(height: 300).cornerRadius(20)
                        Text(selectedPlace).bold().padding().background(Color.futGreen).cornerRadius(20).foregroundStyle(Color.white).offset(y: -120)
                    }
                    
                }.padding()
            }
            
            Spacer()
        }.padding(.top, 30).animation(.default, value: searchText)
    }

    func insertMatch(_ match: fMatch) async throws -> Int {
        let url = "\(apiDir)/api/trainer/insertMatch"
        let parameters: [String: String] = [
            "user_id": "\(user?.id ?? 0)",
            "token": user?.lastTokenKey ?? "",
            "match_date": "\(unixTimestampFromDate(match.date))",
            "map_coords": "\(match.coordinates.latitude),\(match.coordinates.longitude)",
            "place_name": match.coordinates_name,
            "home_team_id": match.homeTeamId != nil ? "\(String(match.homeTeamId!))" : "",
            "home_team_name": match.homeTeamName,
            "away_team_id": match.awayTeamId != nil ? "\(String(match.awayTeamId!))" : "",
            "away_team_name": match.awayTeamName,
            "sub_category_id": "\(fTeam!.subCategoryId)"
        ]
        
        let response = await AF.request(url,
           method: .post,
           parameters: parameters,
           encoding: JSONEncoding.default).serializingData().response

        if let data = response.data, let rawResponse = String(data: data, encoding: .utf8) {
            print("Raw response string: \(rawResponse)")
            // Intenta parsear el JSON
            if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
               let matchId = json["matchId"] as? Int {
                print("Inserted match id: \(matchId)")
            } else {
                print("Match ID not found or incorrect format in response")
            }
            return Int(rawResponse) ?? 1
        }
        return 0
    }
    func stringFromDate(_ date: Date) -> String {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds, .withTimeZone]
        return formatter.string(from: date)
    }
    func unixTimestampFromDate(_ date: Date) -> Int {
        return Int(date.timeIntervalSince1970)
    }
}


#Preview {
    CreateMatchSheetView(showingSheet: {}, loading: .constant(false))
}
