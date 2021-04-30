//
//  SpaceXAPIData.swift
//  SpaceXApp
//
//  Created by Konstantin on 14/03/2020.
//  Copyright © 2020 Konstantin Akchurin. All rights reserved.
//

import Foundation

enum SpaceXAPIData {
    static let scheme = "https"
    static let baseURL = "api.spacexdata.com"
    
    enum Endpoint {
        static let latest = "/latest"
        static let launches = "/launches"
        static let rockets = "/rockets"
        static let rocket = "/rockets"
        static let launchpads = "/launchpads"
    }
    
    enum Version {
        static let v3 = "/v3"
        static let v4 = "/v4"
    }
}
