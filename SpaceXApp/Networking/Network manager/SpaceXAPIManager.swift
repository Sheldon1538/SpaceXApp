//
//  SpaceXAPIManager.swift
//  SpaceXApp
//
//  Created by Konstantin on 14/03/2020.
//  Copyright © 2020 Konstantin Akchurin. All rights reserved.
//

import Foundation

class SpaceXAPIManager {
    static var shared = SpaceXAPIManager()
    
    func getLaunches(offset: Int, completion: @escaping(Result<[SpaceXLaunch], Error>) -> Void) {
        let url = SpaceXAPIData.baseURL+SpaceXAPIData.Endpoint.launches+"?limit=5&offset=\(offset)"
        NetworkManager.shared.sendRequest(urlString: url) { (result) in
            switch result {
            case .success(let data):
                do {
                    let launches = try JSONDecoder().decode([SpaceXLaunch].self, from: data)
                    completion(.success(launches))
                } catch let parseError {
                    completion(.failure(parseError))
                }
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }
    }
}
