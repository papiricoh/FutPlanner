//
//  User.swift
//  FutPlanner
//
//  Created by Pablo Rico alvarez on 11/3/24.
//

import Foundation

struct User: Identifiable, Codable {
    var id: Int
    var username: String
    var first_name: String
    var last_name: String
    var photo_url: String
    var date_of_birth: Date
    var last_token_key: String
    var club_id: Int
    var user_type: String
}
