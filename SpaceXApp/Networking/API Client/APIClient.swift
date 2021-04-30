//
//  APIClient.swift
//  SpaceXApp
//
//  Created by Konstantin on 27.04.2021.
//  Copyright © 2021 Konstantin Akchurin. All rights reserved.
//

import Foundation

typealias ResultCallback<Value> = (Result<Value, Error>) -> Void

protocol APIClient {
    func send<T: APIRequest>(_ request: T, completion: @escaping ResultCallback<T.Response>)
    func loadData(url: String, completion: @escaping ResultCallback<Data>)
}
