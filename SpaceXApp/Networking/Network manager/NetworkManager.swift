//
//  NetworkManager.swift
//  SpaceXApp
//
//  Created by Konstantin on 14/03/2020.
//  Copyright © 2020 Konstantin Akchurin. All rights reserved.
//

import Foundation

class NetworkManager {
    static var shared = NetworkManager()
    
    public func sendRequest(urlString: String, completion: @escaping(Result<Data, Error>) -> Void) {
        let url = URL(string: urlString)
        guard let urlForRequest = url else { return }
        URLSession.shared.dataTask(with: urlForRequest) { (data, urlResponse, error) in
            if let error = error {
                completion(.failure(error))
            }
            if let data = data {
                completion(.success(data))
            }
        }.resume()
    }
}
