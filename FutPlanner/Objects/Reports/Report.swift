//
//  Report.swift
//  FutPlanner
//
//  Created by Pablo Rico alvarez on 12/3/24.
//

import Foundation

struct Report: Identifiable, Codable {
    let id: Int
    let playerId: Int
    let matchId: Int
    let generalPerformance: Int
    let tacticalPerformance: Int
    let passesQuality: Int
    let ballControl: Int
    let gameVision: Int
    let playedTime: Int
    let goals: Int
    let redCards: Int
    let yellowCards: Int
    let match: Match

    enum CodingKeys: String, CodingKey {
        case id
        case playerId = "player_id"
        case matchId = "match_id"
        case generalPerformance = "general_performance"
        case tacticalPerformance = "tactical_performance"
        case passesQuality = "passes_quality"
        case ballControl = "ball_control"
        case gameVision = "game_vision"
        case playedTime = "played_time"
        case goals
        case redCards = "red_cards"
        case yellowCards = "yellow_cards"
        case match
    }
}


struct Match: Codable {
    let id: Int
    let matchDate: String
    let mapCoords: String
    let placeName: String
    let homeTeamId: Int?
    let homeTeamName: String
    let awayTeamId: Int?
    let awayTeamName: String
    let subCategoryId: Int
    let evaluated: Int

    enum CodingKeys: String, CodingKey {
        case id
        case matchDate = "match_date"
        case mapCoords = "map_coords"
        case placeName = "place_name"
        case homeTeamId = "home_team_id"
        case homeTeamName = "home_team_name"
        case awayTeamId = "away_team_id"
        case awayTeamName = "away_team_name"
        case subCategoryId = "sub_category_id"
        case evaluated
    }
}
