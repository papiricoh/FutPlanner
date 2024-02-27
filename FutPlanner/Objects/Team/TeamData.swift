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
}

