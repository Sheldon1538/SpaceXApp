//
//  RocketsViewModel.swift
//  SpaceXApp
//
//  Created by Konstantin on 23.04.2021.
//  Copyright © 2021 Konstantin Akchurin. All rights reserved.
//

import Foundation

protocol RocketsViewModelProtocol: AnyObject {
    var didUpdateRockets: (([RocketViewModel]) -> Void)? { get set }
    func loadImageData(url: String, completion: @escaping(Data) -> Void)
    func fetch()
}

final class RocketsViewModel: RocketsViewModelProtocol {
    var didUpdateRockets: (([RocketViewModel]) -> Void)?
    private var rockets: [SpaceXRocket] = [] {
        didSet {
            didUpdateRockets?(self.rockets.map { RocketViewModel(rocket: $0, networkService: self.networkService) })
        }
    }
    private let networkService: APIManager
    
    init(networkService: APIManager) {
        self.networkService = networkService
    }
    
    func fetch() {
        let urlString = SpaceXAPIData.baseURL + SpaceXAPIData.Version.v4 + SpaceXAPIData.Endpoint.rockets
        networkService.fetch(url: urlString, type: [SpaceXRocket].self) { (result) in
            switch result {
            case .success(let rockets):
                self.rockets = rockets
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func loadImageData(url: String, completion: @escaping(Data) -> Void) {
        networkService.loadData(urlString: url) { (result) in
            switch result {
            case .success(let data):
                completion(data)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
