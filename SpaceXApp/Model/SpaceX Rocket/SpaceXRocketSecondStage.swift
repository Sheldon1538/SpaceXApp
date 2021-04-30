//
//  SpaceXRocketSecondStage.swift
//  SpaceXApp
//
//  Created by Konstantin on 13.02.2021.
//  Copyright © 2021 Konstantin Akchurin. All rights reserved.
//

import Foundation

struct SpaceXRocketSecondStage: Decodable {
    var thrust: SpaceXRocketThrust?
    var payloads: SpaceXRocketSecondStagePayloads?
    var reusable: Bool?
    var engines: Int?
    var fuelAmountTons: Double?
    var burnTimeSec: Int?
    
    enum CodingKeys: String, CodingKey {
        case thrust = "thrust"
        case payloads = "payloads"
        case reusable = "reusable"
        case engines = "engines"
        case fuelAmountTons = "fuel_amount_tons"
        case burnTimeSec = "burn_time_sec"
    }
}
