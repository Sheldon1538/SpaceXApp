//
//  SpaceXRocketFirstStage.swift
//  SpaceXApp
//
//  Created by Konstantin on 14/03/2020.
//  Copyright © 2020 Konstantin Akchurin. All rights reserved.
//

import Foundation

struct SpaceXRocketFirstStage: Codable {
    let cores: [SpaceXRocketFirstStageCore?]
    
    enum CodingKeys: String, CodingKey {
        case cores = "cores"
    }
}
