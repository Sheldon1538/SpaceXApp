//
//  SpaceXAPIManager.swift
//  SpaceXApp
//
//  Created by Konstantin on 14/03/2020.
//  Copyright © 2020 Konstantin Akchurin. All rights reserved.
//

import Foundation

class APIManager {
    public func loadData(urlString: String, completion: @escaping(Result<Data, Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        let urlRequest = URLRequest(url: url)
        let session = URLSession(configuration: .default)
        session.configuration.requestCachePolicy = .returnCacheDataElseLoad
        session.dataTask(with: urlRequest) { (data, urlResponse, error) in
            if let error = error {
                completion(.failure(error))
            }
            if let data = data {
                completion(.success(data))
            }
        }.resume()
    }
    
    func fetch<T: Codable>(url: String, type: T.Type, completion: @escaping(Result<T, Error>) -> Void) {
        loadData(urlString: url) { (result) in
            switch result {
            case .success(let data):
                do {
                    let fetchedObject = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(fetchedObject))
                } catch let error {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
