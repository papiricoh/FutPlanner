//
//  TeamData.swift
//  FutPlanner
//
//  Created by Pablo Rico alvarez on 16/1/24.
//

import Foundation

struct TeamData: Identifiable, Hashable, Codable {
    var id: Int
    var team_name: String
    var shield_url: String
    var category: String
    var subCategory: String

    var players: [Player]
    
    
}

struct Player: Hashable, Codable {
    var id: Int
    var first_name: String
    var last_name: String
    var photo_url: String
    var date_of_birth: Date
    var nationality: String
    var position: String
    var shirt_number: Int
    
    private enum CodingKeys: String, CodingKey {
        case id, first_name, last_name, photo_url, date_of_birth, nationality, position, shirt_number
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        first_name = try container.decode(String.self, forKey: .first_name)
        last_name = try container.decode(String.self, forKey: .last_name)
        photo_url = try container.decode(String.self, forKey: .photo_url)
        nationality = try container.decode(String.self, forKey: .nationality)
        position = try container.decode(String.self, forKey: .position)
        shirt_number = try container.decode(Int.self, forKey: .shirt_number)

        
        let epochTime = try container.decode(TimeInterval.self, forKey: .date_of_birth)
        date_of_birth = Date(timeIntervalSince1970: epochTime)
    }
}

