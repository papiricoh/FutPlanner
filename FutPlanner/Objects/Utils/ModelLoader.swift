//
//  ModelLoader.swift
//  FutPlanner
//
//  Created by Pablo Rico alvarez on 15/1/24.
//

import Foundation
import Alamofire


var matches: [MatchInfo] = load("matchData.json")
var team: TeamData = load("teamData.json")
var reports: [PlayerReport] = load("reports.json")
var user: User? = nil


func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }


    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }


    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

func fetchTokenUser() async throws {
    let url = "\(apiDir)/api/logIn/token"
    let defaults = UserDefaults.standard
    let parameters: [String: String] = [
        "username": defaults.string(forKey: "username") ?? "",
        "token": defaults.string(forKey: "token") ?? ""
    ]
    
    let response: DataResponse<User, AFError> = await AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).serializingDecodable(User.self).response
    
    switch response.result {
    case .success(let auser):
        user = auser
    case .failure(let error):
        throw error
    }
}


func fetchUser(username: String, password: String) async throws {
    let url = "\(apiDir)/api/logIn"
    let parameters: [String: String] = [
        "username": username,
        "password": password
    ]
    
    let response: DataResponse<User, AFError> = await AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).serializingDecodable(User.self).response
    
    switch response.result {
    case .success(let auser):
        user = auser
    case .failure(let error):
        throw error
    }
}
