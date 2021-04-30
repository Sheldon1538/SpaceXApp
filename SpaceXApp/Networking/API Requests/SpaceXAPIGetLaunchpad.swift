//
//  SpaceXAPIGetLaunchpad.swift
//  SpaceXApp
//
//  Created by Konstantin on 29.04.2021.
//  Copyright © 2021 Konstantin Akchurin. All rights reserved.
//

import Foundation

struct SpaceXAPIGetLaunchpad: APIRequest {
    var resourceName: String {
        return SpaceXAPIData.scheme + "://" + SpaceXAPIData.baseURL + SpaceXAPIData.Version.v4 + SpaceXAPIData.Endpoint.launchpads + "/" + id
    }
    
    var request: URLRequest? {
        guard let url = URL(string: resourceName) else { return nil }
        return URLRequest(url: url)
    }
    
    typealias Response = SpaceXLaunchpad
    
    let id: String
    
    init(id: String) {
        self.id = id
    }
}
