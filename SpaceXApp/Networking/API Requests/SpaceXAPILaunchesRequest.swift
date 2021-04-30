//
//  SpaceXAPILaunchesRequest.swift
//  SpaceXApp
//
//  Created by Konstantin on 29.04.2021.
//  Copyright © 2021 Konstantin Akchurin. All rights reserved.
//

import Foundation

struct SpaceXAPILaunches: APIRequest {
    var request: URLRequest? {
        guard let url = URL(string: resourceName) else { return nil }
        return URLRequest(url: url)
    }
    
    var resourceName: String {
        return SpaceXAPIData.scheme + "://" + SpaceXAPIData.baseURL + SpaceXAPIData.Version.v3 + SpaceXAPIData.Endpoint.launches + "?limit=5&offset=\(offset ?? 0)"
    }
    typealias Response = [SpaceXLaunch]
    
    let offset: Int?
    
    init(offset: Int?) {
        self.offset = offset
    }
}
