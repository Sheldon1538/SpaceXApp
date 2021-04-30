//
//  SpaceXLaunchV4Core.swift
//  SpaceXApp
//
//  Created by Konstantin on 27.04.2021.
//  Copyright © 2021 Konstantin Akchurin. All rights reserved.
//

import Foundation

struct SpaceXLaunchV4Core: Decodable {
    var core: String?
    var flight: Int?
    var gridfins: Bool?
    var legs: Bool?
    var reused: Bool?
    var landing_attempt: Bool?
    var landing_success: Bool?
    var landing_type: String?
    var landpad: String?
}
