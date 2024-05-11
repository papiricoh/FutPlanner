//
//  MatchChecker.swift
//  FutPlanner
//
//  Created by Pablo Rico alvarez on 10/5/24.
//

import Foundation

struct MatchChecker: Hashable, Codable {
    var pending_match: fMatch?
    var next_match: fMatch?
    
    private enum CodingKeys: String, CodingKey {
        case pending_match, next_match
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        pending_match = try? container.decode(fMatch?.self, forKey: .pending_match)
        next_match = try? container.decode(fMatch?.self, forKey: .next_match)
        
    }

}

extension MatchChecker {
    init(pending_match: fMatch?, next_match: fMatch?) {
        self.pending_match = pending_match
        self.next_match = next_match
    }
}
