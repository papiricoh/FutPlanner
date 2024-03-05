//
//  MatchInfo.swift
//  FutPlanner
//
//  Created by Pablo Rico alvarez on 15/1/24.
//

import Foundation
import SwiftUI

struct MatchInfo: Identifiable, Hashable, Codable {
    var id: Int
    var homeTeamName: String
    var awayTeamName: String
    var category: String
    var subCategory: String
    var you: Int //0 If you are homTeam 1 if you are away
    var date: Date
    var coordinates_name: String
    var evaluated: Bool

    var coordinates: Coordinates
    
    private enum CodingKeys: String, CodingKey {
        case id, homeTeamName, awayTeamName, category, subCategory, you, date, coordinates_name, evaluated, coordinates
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        homeTeamName = try container.decode(String.self, forKey: .homeTeamName)
        awayTeamName = try container.decode(String.self, forKey: .awayTeamName)
        category = try container.decode(String.self, forKey: .category)
        subCategory = try container.decode(String.self, forKey: .subCategory)
        you = try container.decode(Int.self, forKey: .you)
        coordinates_name = try container.decode(String.self, forKey: .coordinates_name)
        evaluated = try container.decode(Bool.self, forKey: .evaluated)
        coordinates = try container.decode(Coordinates.self, forKey: .coordinates)

        
        let epochTime = try container.decode(TimeInterval.self, forKey: .date)
        date = Date(timeIntervalSince1970: epochTime)
    }
}
struct Coordinates: Hashable, Codable {
    var latitude: Double
    var longitude: Double
}

extension MatchInfo {
    init(id: Int, homeTeamName: String, awayTeamName: String, category: String, subCategory: String, you: Int, date: Date, coordinates_name: String, evaluated: Bool, coordinates: Coordinates) {
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
    }
}
