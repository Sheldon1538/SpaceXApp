//
//  LaunchesViewModel.swift
//  SpaceXApp
//
//  Created by Konstantin on 18.04.2021.
//  Copyright © 2021 Konstantin Akchurin. All rights reserved.
//

import Foundation

protocol LaunchesViewModelProtocol {
    var  didUpdateLaunches: (([LaunchViewModel]) -> Void)? { get set }
    func didScrollAllLaunches()
    func loadImageData(url: String, completion: @escaping(Data) -> Void)
}

final class LaunchesViewModel: LaunchesViewModelProtocol {
    var didUpdateLaunches: (([LaunchViewModel]) -> Void)?
    
    private var spaceXLaunches: [SpaceXLaunch] = [] {
        didSet {
            didUpdateLaunches?(spaceXLaunches.map { LaunchViewModel(launch: $0) })
        }
    }
    var loadedAllLaunches = false
    
    private let networkService: APIManager
    private var launchPaginationOffset = 0
    
    init(networkService: APIManager) {
        self.networkService = networkService
    }
    
    private func loadLaunches() {
        networkService.fetch(url: SpaceXGetLaunchesURL(offset: launchPaginationOffset).getURL(), type: [SpaceXLaunch].self) { (result) in
            switch result {
            case .success(let launches):
                if launches.isEmpty {
                    self.loadedAllLaunches = true
                } else {
                    self.launchPaginationOffset += launches.count
                    self.spaceXLaunches += launches
                }
            case .failure(let error):
                print(error.localizedDescription)
                // TODO: Error handling.
            }
        }
    }
    
    func didScrollAllLaunches() {
        if !loadedAllLaunches {
            loadLaunches()
        }
    }
    
    func loadImageData(url: String, completion: @escaping(Data) -> Void) {
        networkService.loadData(urlString: url) { (result) in
            switch result {
            case .success(let data):
                completion(data)
            case .failure(let error):
                print(error.localizedDescription)
            // TODO: Error handling
            }
        }
        
    }
}
