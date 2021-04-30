//
//  RocketsViewModel.swift
//  SpaceXApp
//
//  Created by Konstantin on 23.04.2021.
//  Copyright © 2021 Konstantin Akchurin. All rights reserved.
//

import Foundation

protocol RocketsViewModelProtocol: ViewModelImageRepresentable, AnyObject {
    var didUpdateRockets: (([RocketViewModel]) -> Void)? { get set }
    func fetch()
}

final class RocketsViewModel: RocketsViewModelProtocol {
    var didUpdateRockets: (([RocketViewModel]) -> Void)?
    private var rockets: [SpaceXRocket] = [] {
        didSet {
            didUpdateRockets?(self.rockets.map { RocketViewModel(rocket: $0, apiService: self.apiService) })
        }
    }
    private let apiService: APIClient
    
    init(apiService: APIClient) {
        self.apiService = apiService
    }
    
    func fetch() {
        let request = SpaceXRocketsRequest()
        apiService.send(request) { (result) in
            switch result {
            case .success(let rockets):
                self.rockets = rockets
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func loadImageData(url: String, completion: @escaping(Data) -> Void) {
        apiService.loadData(url: url) { (result) in
            switch result {
            case .success(let data):
                completion(data)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
