//
//  SpaceXRocketFirstStage.swift
//  SpaceXApp
//
//  Created by Konstantin on 13.02.2021.
//  Copyright © 2021 Konstantin Akchurin. All rights reserved.
//

import Foundation

struct SpaceXRocketFirstStage: Decodable {
    var thrustSeaLevel: SpaceXRocketThrust?
    var thrustVacuum: SpaceXRocketThrust?
    var reusable: Bool?
    var engines: Int?
    var fuelAmountTons: Double?
    var burnTimeSec: Int?
    
    enum CodingKeys: String, CodingKey {
        case thrustSeaLevel = "thrust_sea_level"
        case thrustVacuum = "thrust_vacuum"
        case reusable = "reusable"
        case engines = "engines"
        case fuelAmountTons = "fuel_amount_tons"
        case burnTimeSec = "burn_time_sec"
    }
}
