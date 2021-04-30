//
//  SpaceXRocketEngines.swift
//  SpaceXApp
//
//  Created by Konstantin on 13.02.2021.
//  Copyright © 2021 Konstantin Akchurin. All rights reserved.
//

import Foundation

struct SpaceXRocketEngines: Decodable {
    var isp: SpaceXRocketEnginesISP?
    var thrustSeaLevel: SpaceXRocketThrust?
    var thrustVacuum: SpaceXRocketThrust?
    var number: Int?
    var type: String?
    var version: String?
    var layout: String?
    var engineLossMax: Int?
    var propellant1: String?
    var propellant2: String?
    var thrustToWeight: Double?
    
    enum CodingKeys: String, CodingKey {
        case isp = "isp"
        case thrustSeaLevel = "thrust_sea_level"
        case thrustVacuum = "thrust_vacuum"
        case number = "number"
        case type = "type"
        case version = "version"
        case layout = "layout"
        case engineLossMax = "engine_loss_max"
        case propellant1 = "propellant_1"
        case propellant2 = "propellant_2"
        case thrustToWeight = "thrust_to_weight"
    }
}
