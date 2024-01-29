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
    var reports: [Report]
}

struct Report: Hashable, Codable {
    var id: Int
    var match_id: Int
    var general_performance: Int
    var tactical_performance: Int
    var played_time: Int
    var goals: Int
    var red_cards: Int
    var yellow_cards: Int
    
    
}
