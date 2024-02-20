//
//  PlayerReport.swift
//  FutPlanner
//
//  Created by Pablo Rico alvarez on 3/2/24.
//

import Foundation

struct PlayerReport: Identifiable, Hashable, Codable {
    var id: Int
    var playerId: Int
    var matchId: Int
    var match: MatchInfo?
    
    var generalPerformance: Int
    var tacticalPerformance: Int
    var passesQuality: Int
    var ballControl: Int
    var gameVision: Int
    
    var playedTime: Float
    var goals: Int
    var redCards: Int
    var yellowCards: Int
    
    
}
