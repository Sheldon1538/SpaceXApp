//
//  SpaceXAPIQueryLaunchesRequest.swift
//  SpaceXApp
//
//  Created by Konstantin on 29.04.2021.
//  Copyright © 2021 Konstantin Akchurin. All rights reserved.
//

import Foundation

struct SpaceXAPIQueryLaunches: APIRequest {
    var request: URLRequest? {
        guard let url = URL(string: resourceName) else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        let options: [String: Any] = ["options": [
                "limit": 5,
                "offset": offset
            ]]
        guard let jsonData = try? JSONSerialization.data(withJSONObject: options) else { return nil }
        urlRequest.httpBody = jsonData
        urlRequest.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        return urlRequest
    }
    
    typealias Response = SpaceXLaunchV4
    
    let offset: Int
    
    var resourceName: String {
        return SpaceXAPIData.scheme + "://" + SpaceXAPIData.baseURL + SpaceXAPIData.Version.v4 + SpaceXAPIData.Endpoint.launches + "/query"
    }
    
    init(offset: Int) {
        self.offset = offset
    }
}
