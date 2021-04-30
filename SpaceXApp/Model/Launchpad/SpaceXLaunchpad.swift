//
//  SpaceXLaunchpad.swift
//  SpaceXApp
//
//  Created by Konstantin on 29.04.2021.
//  Copyright © 2021 Konstantin Akchurin. All rights reserved.
//

import Foundation

struct SpaceXLaunchpad: Decodable {
    var name: String?
    var full_name: String?
    var locality: String?
    var region: String?
    var timezone: String?
    var latitude: Double?
    var longitude: Double?
    var launch_attempts: Int?
    var launch_successes: Int?
    var rockets: [String]?
    var launches: [String]?
    var details: String?
    var status: String?
    var id: String?
}
