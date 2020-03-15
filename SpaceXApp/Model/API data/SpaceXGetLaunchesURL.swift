//
//  SpaceXGetLaunchesURL.swift
//  SpaceXApp
//
//  Created by Konstantin on 15/03/2020.
//  Copyright © 2020 Konstantin Akchurin. All rights reserved.
//

import Foundation

struct SpaceXGetLaunchesURL {
    private var offset: Int
    
    init(offset: Int) {
        self.offset = offset
    }
    
    func getURL() -> String {
        let urlString = SpaceXAPIData.baseURL + SpaceXAPIData.Endpoint.launches + "?limit=5&offset=\(offset)"
        return urlString
    }
}
