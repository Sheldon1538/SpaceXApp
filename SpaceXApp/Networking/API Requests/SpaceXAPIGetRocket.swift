//
//  SpaceXAPIGetRocket.swift
//  SpaceXApp
//
//  Created by Konstantin on 30.04.2021.
//  Copyright © 2021 Konstantin Akchurin. All rights reserved.
//

import Foundation

struct SpaceXAPIGetRocket: APIRequest {
    var resourceName: String {
        return SpaceXAPIData.scheme + "://" + SpaceXAPIData.baseURL + SpaceXAPIData.Version.v4 + SpaceXAPIData.Endpoint.rocket + "/" + id
    }
    
    var request: URLRequest? {
        guard let url = URL(string: resourceName) else { return nil }
        return URLRequest(url: url)
    }
    
    typealias Response = SpaceXRocket
    
    let id: String
    
    init(id: String) {
        self.id = id
    }
    
}
