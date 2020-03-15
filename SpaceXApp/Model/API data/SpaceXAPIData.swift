//
//  SpaceXAPIData.swift
//  SpaceXApp
//
//  Created by Konstantin on 14/03/2020.
//  Copyright © 2020 Konstantin Akchurin. All rights reserved.
//

import Foundation

enum SpaceXAPIData {
    static let baseURL = "https://api.spacexdata.com/v3"
    
    enum Endpoint {
        static let latest = "/latest"
        static let launches = "/launches"
    }
}
