//
//  SpaceXRocketThrust.swift
//  SpaceXApp
//
//  Created by Konstantin on 13.02.2021.
//  Copyright © 2021 Konstantin Akchurin. All rights reserved.
//

import Foundation

struct SpaceXRocketThrust: Decodable {
    var kn: Int?
    var lbf: Int?
    
    enum CodingKeys: String, CodingKey {
        case kn = "kN"
        case lbf = "lbf"
    }
}
