//
//  SpaceXRocket.swift
//  SpaceXApp
//
//  Created by Konstantin on 13.02.2021.
//  Copyright © 2021 Konstantin Akchurin. All rights reserved.
//

import Foundation

struct SpaceXRocket: Codable {
    var height: SpaceXRocketSize?
    var diameter: SpaceXRocketSize?
    var mass: SpaceXRocketMass?
    var firstStage: SpaceXRocketFirstStage?
    var secondStage: SpaceXRocketSecondStage?
    var engines: SpaceXRocketEngines?
    var landingLegs: SpaceXRocketLandingLegs?
    var payloadWeights: [SpaceXRocketPayloadWeight?]
    var flickrImages: [String?]
    var name: String?
    var type: String?
    var active: Bool?
    var stages: Int?
    var boosters: Int?
    var costPerLaunch: Int?
    var successRatePct: Int?
    var firstFlight: String?
    var country: String?
    var company: String?
    var wikipedia: String?
    var description: String?
    var id: String?
    
    enum CodingKeys: String, CodingKey {
        case height = "height"
        case diameter = "diameter"
        case mass = "mass"
        case firstStage = "first_stage"
        case secondStage = "second_stage"
        case engines = "engines"
        case landingLegs = "landing_legs"
        case payloadWeights = "payload_weights"
        case flickrImages = "flickr_images"
        case name = "name"
        case type = "type"
        case active = "active"
        case stages = "stages"
        case boosters = "boosters"
        case costPerLaunch = "cost_per_launch"
        case successRatePct = "success_rate_pct"
        case firstFlight = "first_flight"
        case country = "country"
        case company = "company"
        case wikipedia = "wikipedia"
        case description = "description"
        case id = "id"
    }
}
