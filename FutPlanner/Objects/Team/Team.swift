//
//  Team.swift
//  FutPlanner
//
//  Created by Pablo Rico alvarez on 11/3/24.
//

import Foundation

struct Team: Codable {
    let id: Int
    let teamName: String
    let shieldUrl: String?
    let subCategoryId, clubId: Int
    let players: [Player]
    let club: Club

    enum CodingKeys: String, CodingKey {
        case id
        case teamName = "team_name"
        case shieldUrl = "shield_url"
        case subCategoryId = "sub_category_id"
        case clubId = "club_id"
        case players, club
    }
}

struct Player: Codable {
    let id: Int
    let firstName, lastName: String
    let photoUrl: String?
    let dateOfBirth: String?
    let playerId: Int
    let position: String
    let shirtNumber: Int?
    let nationality: String?

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case photoUrl = "photo_url"
        case dateOfBirth = "date_of_birth"
        case playerId = "player_id"
        case position
        case shirtNumber = "shirt_number"
        case nationality
    }
}

struct Club: Codable {
    let id: Int
    let clubName: String
    let shieldUrl: String?
    let ownerId: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case clubName = "club_name"
        case shieldUrl = "shield_url"
        case ownerId = "owner_id"
    }
}
