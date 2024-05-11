//
//  TeamAnalytic.swift
//  FutPlanner
//
//  Created by Pablo Rico alvarez on 11/5/24.
//

import Foundation

struct TeamAnalytic: Identifiable, Hashable, Codable {
    let id: UUID
    let total_reports, total_matches: Int
    let avg_general_performance, avg_tactical_performance, avg_passes_quality, avg_ball_control, avg_game_vision, avg_played_time, total_played_time, total_goals, total_red_cards, total_yellow_cards, performancePerMinute, goalRate: Double?
    

    enum CodingKeys: String, CodingKey {
        case total_reports, total_matches, avg_general_performance, avg_tactical_performance, avg_passes_quality, avg_ball_control, avg_game_vision, avg_played_time, total_played_time, total_goals, total_red_cards, total_yellow_cards, performancePerMinute, goalRate
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = UUID()
        total_reports = try container.decode(Int.self, forKey: .total_reports)
        total_matches = try container.decode(Int.self, forKey: .total_matches)
        
        avg_general_performance = decodeDouble(forKey: .avg_general_performance)
        avg_tactical_performance = decodeDouble(forKey: .avg_tactical_performance)
        avg_passes_quality = decodeDouble(forKey: .avg_passes_quality)
        avg_ball_control = decodeDouble(forKey: .avg_ball_control)
        avg_game_vision = decodeDouble(forKey: .avg_game_vision)
        avg_played_time = decodeDouble(forKey: .avg_played_time)
        total_played_time = decodeDouble(forKey: .total_played_time)
        total_goals = decodeDouble(forKey: .total_goals)
        total_red_cards = decodeDouble(forKey: .total_red_cards)
        total_yellow_cards = decodeDouble(forKey: .total_yellow_cards)
        
        
        performancePerMinute = try? container.decode(Double?.self, forKey: .performancePerMinute)
        goalRate = try? container.decode(Double?.self, forKey: .goalRate)
        
        func decodeDouble(forKey key: CodingKeys) -> Double? {
            if let stringValue = try? container.decode(String.self, forKey: key) {
                return Double(stringValue)
            }
            return nil
        }
    }
}
