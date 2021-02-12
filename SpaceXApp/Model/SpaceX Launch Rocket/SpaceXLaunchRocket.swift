//
//  SpaceXLaunchRocket.swift
//  SpaceXApp
//
//  Created by Konstantin on 14/03/2020.
//  Copyright © 2020 Konstantin Akchurin. All rights reserved.
//

import Foundation

struct SpaceXLaunchRocket: Codable {
    let rocketID:    String?
    let rocketName:  String?
    let rocketType:  String?
    let firstStage:  SpaceXLaunchRocketFirstStage?
    let secondStage: SpaceXLaunchRocketSecondStage?
    let fairings:    SpaceXLaunchRocketFairings?
    
    enum CodingKeys: String, CodingKey {
        case rocketID    = "rocket_id"
        case rocketName  = "rocket_name"
        case rocketType  = "rocket_type"
        case firstStage  = "first_stage"
        case secondStage = "second_stage"
        case fairings    = "fairings"
    }
}
