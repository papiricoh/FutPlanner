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
    let players: [Player]?
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

struct Player: Hashable, Codable {
    let id: Int
    let firstName, lastName: String
    let photoUrl: String?
    let dateOfBirth: String?
    let playerId: Int
    let position: String
    let shirtNumber: Int?
    let nationality: String?
    let dateOfBirthDate: Date?

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
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        firstName = try container.decode(String.self, forKey: .firstName)
        lastName = try container.decode(String.self, forKey: .lastName)
        photoUrl = try? container.decode(String.self, forKey: .photoUrl)
        dateOfBirth = try? container.decode(String.self, forKey: .dateOfBirth)
        playerId = try container.decode(Int.self, forKey: .playerId)
        position = try container.decode(String.self, forKey: .position)
        shirtNumber = try? container.decode(Int.self, forKey: .shirtNumber)
        nationality = try? container.decode(String.self, forKey: .nationality)
        

        if(dateOfBirth != nil) {
            let dateFormatter = ISO8601DateFormatter()
            dateOfBirthDate = dateFormatter.date(from: dateOfBirth ?? "")
        }else {
            dateOfBirthDate = nil
        }
    }
}
extension Player {
    // Inicializador adicional para crear instancias hardcodeadas de Player
    init(id: Int, firstName: String, lastName: String, photoUrl: String? = nil, dateOfBirth: String? = nil, playerId: Int, position: String, shirtNumber: Int? = nil, nationality: String? = nil) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.photoUrl = photoUrl
        self.dateOfBirth = dateOfBirth
        self.playerId = playerId
        self.position = position
        self.shirtNumber = shirtNumber
        self.nationality = nationality
        
        if let dob = dateOfBirth, let dobDate = ISO8601DateFormatter().date(from: dob) {
            self.dateOfBirthDate = dobDate
        } else {
            self.dateOfBirthDate = nil
        }
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
