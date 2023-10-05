//
//  Item.swift
//  FutPlanner
//
//  Created by Pablo Rico alvarez on 5/10/23.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
