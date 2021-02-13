//
//  SpaceXRocketEnginesISP.swift
//  SpaceXApp
//
//  Created by Konstantin on 13.02.2021.
//  Copyright © 2021 Konstantin Akchurin. All rights reserved.
//

import Foundation

struct SpaceXRocketEnginesISP: Codable {
    var seaLevel: Int?
    var vacuum: Int?
    
    enum CodinkKeys: String, CodingKey {
        case seaLevel = "sea_level"
        case vacuum = "vacuum"
    }
}
