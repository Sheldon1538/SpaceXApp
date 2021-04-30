//
//  SpaceXLaunchV4Doc.swift
//  SpaceXApp
//
//  Created by Konstantin on 27.04.2021.
//  Copyright © 2021 Konstantin Akchurin. All rights reserved.
//

import Foundation

struct SpaceXLaunchV4Doc: Decodable {
    var fairings: SpaceXLaunchRocketFairings?
    var links: SpaceXLaunchV4Links?
    var static_fire_date_utc: String?
    var static_fire_date_unix: Int?
    var tbd: Bool?
    var net: Bool?
    var window: Int?
    var rocket: String?
    var success: Bool?
    var details: String?
    var crew: [String]?
    var ships: [String]?
    var capsules: [String]?
    var payloads: [String]?
    var launchpad: String?
    var auto_update: Bool?
    var launch_library_id: String?
    var failures: [SpaceXLaunchV4Failure]?
    var flight_number: Int?
    var name: String?
    var date_utc: String?
    var date_unix: Int?
    var date_local: String?
    var date_precision: String?
    var upcoming: Bool?
    var cores: [SpaceXLaunchV4Core]?
    var id: String?
}
