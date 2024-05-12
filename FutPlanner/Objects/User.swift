//
//  User.swift
//  FutPlanner
//
//  Created by Pablo Rico alvarez on 11/3/24.
//

import Foundation

struct User: Identifiable, Codable {
    var id: Int
    var username, firstName, lastName, dateOfBirth, lastTokenKey: String
    var photoUrl: String?
    var dateOfBirthDate: Date?
    var clubId: Int
    var userType: String
    
    enum CodingKeys: String, CodingKey {
        case id, username
        case firstName = "first_name"
        case lastName = "last_name"
        case photoUrl = "photo_url"
        case dateOfBirth = "date_of_birth"
        case lastTokenKey = "last_token_key"
        case clubId = "club_id"
        case userType = "user_type"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        username = try container.decode(String.self, forKey: .username)
        firstName = try container.decode(String.self, forKey: .firstName)
        lastName = try container.decode(String.self, forKey: .lastName)
        photoUrl = try? container.decode(String?.self, forKey: .photoUrl)
        dateOfBirth = try container.decode(String.self, forKey: .dateOfBirth)
        lastTokenKey = try container.decode(String.self, forKey: .lastTokenKey)
        clubId = try container.decode(Int.self, forKey: .clubId)
        userType = try container.decode(String.self, forKey: .userType)

        
        let dateFormatter = ISO8601DateFormatter()
        dateOfBirthDate = dateFormatter.date(from: dateOfBirth)
    }
}
