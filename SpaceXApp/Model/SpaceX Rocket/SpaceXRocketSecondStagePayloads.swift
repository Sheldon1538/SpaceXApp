//
//  SpaceXRocketSecondStagePayloads.swift
//  SpaceXApp
//
//  Created by Konstantin on 13.02.2021.
//  Copyright © 2021 Konstantin Akchurin. All rights reserved.
//

import Foundation

struct SpaceXRocketSecondStagePayloads: Decodable {
    var compositeFairing: SpaceXRocketSecondStagePaylodsCompositeFairings?
    var option: String?
    
    enum CodingKeys: String, CodingKey {
        case compositeFairing = "composite_fairing"
        case option = "option_1"
    }
}
