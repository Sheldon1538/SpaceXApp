//
//  SpaceXRocketFirstStageCore.swift
//  SpaceXApp
//
//  Created by Konstantin on 14/03/2020.
//  Copyright © 2020 Konstantin Akchurin. All rights reserved.
//

import Foundation

struct SpaceXRocketFirstStageCore: Codable {
    let coreSerial:     String?
    let flight:         Int?
    let block:          Int?
    let gridfins:       Bool?
    let legs:           Bool?
    let reused:         Bool?
    let landSuccess:    Bool?
    let landingIntent:  Bool?
    let landingType:    String?
    let landingVehicle: String?
    
    enum CodingKeys: String, CodingKey {
        case coreSerial =     "core_serial"
        case flight =         "flight"
        case block =          "block"
        case gridfins =       "gridfins"
        case legs =           "legs"
        case reused =         "reused"
        case landSuccess =    "land_success"
        case landingIntent =  "landing_intent"
        case landingType =    "landing_type"
        case landingVehicle = "landing_vehicle"
    }
}
