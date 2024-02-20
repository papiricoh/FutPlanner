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
    
}
struct Coordinates: Hashable, Codable {
    var latitude: Double
    var longitude: Double
}
