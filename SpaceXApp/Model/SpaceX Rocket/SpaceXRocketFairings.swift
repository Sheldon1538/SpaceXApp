//
//  SpaceXRocketFairings.swift
//  SpaceXApp
//
//  Created by Konstantin on 14/03/2020.
//  Copyright © 2020 Konstantin Akchurin. All rights reserved.
//

import Foundation

struct SpaceXRocketFairings: Codable {
    let reused: Bool?
    let recoveryAttempt: Bool?
    let recovered: Bool?
    let ship: Bool?
    
    enum CodingKeys: String, CodingKey {
        case reused = "reused"
        case recoveryAttempt = "recovery_attempt"
        case recovered = "recovered"
        case ship = "ship"
    }
}
