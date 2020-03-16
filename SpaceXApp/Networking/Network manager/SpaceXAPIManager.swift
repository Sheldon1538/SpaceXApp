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
    
    func fetch<T: Codable>(url: String, type: T.Type, completion: @escaping(Result<T, Error>) -> Void) {
        NetworkManager.shared.loadData(urlString: url) { (result) in
            switch result {
            case .success(let data):
                do {
                    let launches = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(launches))
                } catch let parseError {
                    completion(.failure(parseError))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
