//
//  SpaceXLaunchRocketFirstStage.swift
//  SpaceXApp
//
//  Created by Konstantin on 14/03/2020.
//  Copyright © 2020 Konstantin Akchurin. All rights reserved.
//

import Foundation

struct SpaceXLaunchRocketFirstStage: Codable {
    let cores: [SpaceXLaunchRocketFirstStageCore?]
    
    enum CodingKeys: String, CodingKey {
        case cores = "cores"
    }
}
