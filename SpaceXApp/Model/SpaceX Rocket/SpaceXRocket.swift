//
//  SpaceXRocket.swift
//  SpaceXApp
//
//  Created by Konstantin on 14/03/2020.
//  Copyright © 2020 Konstantin Akchurin. All rights reserved.
//

import Foundation

struct SpaceXRocket: Codable {
    let rocketID: String?
    let rocketName: String?
    let rocketType: String?
    let firstStage: SpaceXRocketFirstStage?
    let secondStage: SpaceXRocketSecondStage?
    let fairings: SpaceXRocketFairings?
    
    enum CodingKeys: String, CodingKey {
        case rocketID = "rocket_id"
        case rocketName = "rocket_name"
        case rocketType = "rocket_type"
        case firstStage = "first_stage"
        case secondStage = "second_stage"
        case fairings = "fairings"
    }
}
