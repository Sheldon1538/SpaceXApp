//
//  SpaceXRocketSecondStagePayload.swift
//  SpaceXApp
//
//  Created by Konstantin on 14/03/2020.
//  Copyright © 2020 Konstantin Akchurin. All rights reserved.
//

import Foundation

struct SpaceXRocketSecondStagePayload: Codable {
    let payloadID:       String?
    let noradID:         [Int?]
    let capSerial:       String?
    let reused:          Bool?
    let customers:       [String?]
    let nationality:     String?
    let manufacturer:    String?
    let payloadType:     String?
    let payloadMassKG:   Double?
    let payloadMassLBS:  Double?
    let orbit:           String?
    let orbitParams:     SpaceXRocketSecondStagePayloadOrbitParams?
    let massReturnedKG:  Double?
    let massReturnedLBS: Double?
    let flightTimeSEC:   Double?
    let cargoManifest:   String?
    
    enum CodingKeys: String, CodingKey {
        case payloadID       = "payload_id"
        case noradID         = "norad_id"
        case capSerial       = "cap_serial"
        case reused          = "reused"
        case customers       = "customers"
        case nationality     = "nationality"
        case manufacturer    = "manufacturer"
        case payloadType     = "payload_type"
        case payloadMassKG   = "payload_mass_kg"
        case payloadMassLBS  = "payload_mass_lbs"
        case orbit           = "orbit"
        case orbitParams     = "orbit_params"
        case massReturnedKG  = "mass_returned_kg"
        case massReturnedLBS = "mass_returned_lbs"
        case flightTimeSEC   = "flight_time_sec"
        case cargoManifest   = "cargo_manifest"
    }
}
