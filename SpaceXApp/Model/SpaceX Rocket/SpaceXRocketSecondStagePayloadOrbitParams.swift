//
//  SpaceXRocketSecondStagePayloadOrbitParams.swift
//  SpaceXApp
//
//  Created by Konstantin on 14/03/2020.
//  Copyright © 2020 Konstantin Akchurin. All rights reserved.
//

import Foundation

struct SpaceXRocketSecondStagePayloadOrbitParams: Codable {
    let referenceSystem: String?
    let regime: String?
    let longitude: Double?
    let semiMajorAxiKM: Double?
    let eccentricity: Double?
    let periapsisKM: Double?
    let apoapsisKM: Double?
    let inclinationDEG: Double?
    let periodMin: Double?
    let lifespanYears: Int?
    let epoch: String?
    let meanMotion: Double?
    let raan: Double?
    let argOfPericenter: Double?
    let meanAnomaly: Double?
    
    enum CodingKeys: String, CodingKey {
        case referenceSystem = "reference_system"
        case regime = "regime"
        case longitude = "longitude"
        case semiMajorAxiKM = "semi_major_axis_km"
        case eccentricity = "eccentricity"
        case periapsisKM = "periapsis_km"
        case apoapsisKM = "apoapsis_km"
        case inclinationDEG = "inclination_deg"
        case periodMin = "period_min"
        case lifespanYears = "lifespan_years"
        case epoch = "epoch"
        case meanMotion = "mean_motion"
        case raan = "raan"
        case argOfPericenter = "arg_of_pericenter"
        case meanAnomaly = "mean_anomaly"
    }
}
