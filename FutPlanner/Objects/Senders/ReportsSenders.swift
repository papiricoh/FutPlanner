//
//  ReportsSenders.swift
//  FutPlanner
//
//  Created by Pablo Rico alvarez on 10/5/24.
//

import Foundation


//Generamos las estructuras aqui ya que no se van a usar en ningun otro lugar
struct senderMatchReport: Codable {
    let userId: Int
    let token: String?
    let matchId: Int
    let reports: [senderPlayerReport]
    
    init(userId: Int, token: String?, matchId: Int, reports: [senderPlayerReport]) {
        self.userId = userId
        self.token = token
        self.matchId = matchId
        self.reports = reports
    }
}

struct senderPlayerReport: Codable {
    let playerId: Int
    let generalPerformance: Int
    let tacticalPerformance: Int
    let passesQuality: Int
    let ballControl: Int
    let gameVision: Int
    let playedTime: Int
    let goals: Int
    let redCards: Int
    let yellowCards: Int
    
    
}
