//
//  Match.swift
//  FutPlanner
//
//  Created by Pablo Rico alvarez on 16/4/24.
//

import Foundation

struct fMatch: Identifiable, Hashable, Codable {
    var id: Int
    var homeTeamName: String
    var awayTeamName: String
    var category: String
    var subCategory: String
    var you: Int //0 If you are homeTeam 1 if you are away
    var date: Date
    var coordinates_name: String
    var evaluated: Bool
    var homeTeamId: Int?
    var awayTeamId: Int?

    var coordinates: Coordinates
    
    private enum CodingKeys: String, CodingKey {
        case id, category, subCategory, you, evaluated
        case date = "match_date"
        case homeTeamName = "home_team_name"
        case awayTeamName = "away_team_name"
        case coordinates_name = "place_name"
        case coordinates = "map_coords"
        case homeTeamId = "home_team_id"
        case awayTeamId = "away_team_id"
        
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(Int.self, forKey: .id)
        homeTeamName = try container.decode(String.self, forKey: .homeTeamName)
        awayTeamName = try container.decode(String.self, forKey: .awayTeamName)
        category = "Alevines"
        subCategory = "1"
        
        homeTeamId = try container.decodeIfPresent(Int.self, forKey: .homeTeamId)
        awayTeamId = try container.decodeIfPresent(Int.self, forKey: .awayTeamId)
        
        you = homeTeamId == fTeam?.id ? 0 : 1
        coordinates_name = try container.decode(String.self, forKey: .coordinates_name)
        let evalNumber = try container.decode(Int.self, forKey: .evaluated)
        evaluated = evalNumber == 1

        let dateString = try container.decode(String.self, forKey: .date)
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        if let date = formatter.date(from: dateString) {
            self.date = date
        } else {
            print("Fechas no válidas: \(dateString)")
            throw DecodingError.dataCorruptedError(forKey: .date, in: container, debugDescription: "Fecha no válida")
        }
        
        let coordsString = try container.decode(String.self, forKey: .coordinates)
        let coordsParts = coordsString.split(separator: ",").map { Double($0) ?? 0.0 }
        if coordsParts.count == 2 {
            coordinates = Coordinates(latitude: coordsParts[0], longitude: coordsParts[1])
        } else {
            print("Coordenadas no válidas")
            throw DecodingError.dataCorruptedError(forKey: .coordinates, in: container, debugDescription: "Coordenadas no válidas")
        }
    }

}

extension fMatch {
    init(id: Int, homeTeamName: String, awayTeamName: String, category: String, subCategory: String, you: Int, date: Date, coordinates_name: String, evaluated: Bool, coordinates: Coordinates, homeTeamId: Int?, awayTeamId: Int?) {
        self.id = id
        self.homeTeamName = homeTeamName
        self.awayTeamName = awayTeamName
        self.category = category
        self.subCategory = subCategory
        self.you = you
        self.date = date
        self.coordinates_name = coordinates_name
        self.evaluated = evaluated
        self.coordinates = coordinates
        self.homeTeamId = homeTeamId
        self.awayTeamId = awayTeamId
    }
}
