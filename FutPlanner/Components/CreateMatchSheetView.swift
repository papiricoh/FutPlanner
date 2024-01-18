//
//  BottomSheetView.swift
//  FutPlanner
//
//  Created by Pablo Rico alvarez on 18/1/24.
//

import SwiftUI
import MapKit
import LocationPicker

struct CreateMatchSheetView: View {
    @State private var rivalTeamName: String = ""
    @State private var isHomeTeam: Bool = true
    @State private var date: Date = Date()
    @State private var stadiumName: String = ""
    
    @State private var coordinates = CLLocationCoordinate2D(latitude: 43.359496, longitude: -5.8653342)

    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Text("Añade un partido").bold().font(.title2)
                Spacer()
                Button(action: {}) {
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
                    HStack {
                        Image(systemName: "sportscourt")
                        TextField("Nombre del estadio", text: $stadiumName)
                        Button(action: {}) {
                            Text("Buscar")
                        }
                    }.cornerRadius(20).padding().overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.futGreen, lineWidth: 5)
                    )
                    LocationPicker(instructions: "Presiona la localizacion del estadio", coordinates: $coordinates, zoomLevel: 500.0).frame(height: 360)
                }.padding()
            }
            
            Spacer()
        }.padding(.top, 30)
    }

}


#Preview {
    CreateMatchSheetView()
}
