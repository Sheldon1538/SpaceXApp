//
//  SpaceXLaunchRocketSecondStage.swift
//  SpaceXApp
//
//  Created by Konstantin on 14/03/2020.
//  Copyright © 2020 Konstantin Akchurin. All rights reserved.
//

import Foundation

struct SpaceXLaunchRocketSecondStage: Codable {
    let block:    Int?
    let payloads: [SpaceXLaunchRocketSecondStagePayload?]
    
    enum CodingKeys: String, CodingKey {
        case block    = "block"
        case payloads = "payloads"
    }
}
