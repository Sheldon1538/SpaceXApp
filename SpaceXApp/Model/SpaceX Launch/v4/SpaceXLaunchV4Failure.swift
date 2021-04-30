//
//  SpaceXLaunchV4Failure.swift
//  SpaceXApp
//
//  Created by Konstantin on 27.04.2021.
//  Copyright © 2021 Konstantin Akchurin. All rights reserved.
//

import Foundation

struct SpaceXLaunchV4Failure: Decodable {
    var time: Int?
    var altitude: Double?
    var reason: String?
}
