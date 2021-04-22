//
//  LaunchesViewModel.swift
//  SpaceXApp
//
//  Created by Konstantin on 18.04.2021.
//  Copyright © 2021 Konstantin Akchurin. All rights reserved.
//

import Foundation

final class LaunchesViewModel {
    var didUpdateLaunches: (([SpaceXLaunch]) -> Void)?
    
    private var spaceXLaunches: [SpaceXLaunch] = [] {
        didSet {
            didUpdateLaunches?(self.spaceXLaunches)
        }
    }
    var loadedAllLaunches = false
    
    private let networkService: APIManager
    private var launchPaginationOffset = 0
    private var imageDataCache = NSCache<NSString, NSData>()
    
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
        let cacheID = NSString(string: url)
        if let cachedData = imageDataCache.object(forKey: cacheID) {
            completion(cachedData as Data)
        } else {
            networkService.loadData(urlString: url) { (result) in
                switch result {
                case .success(let data):
                    self.imageDataCache.setObject(data as NSData, forKey: cacheID)
                    completion(data)
                case .failure(let error):
                    print(error.localizedDescription)
                    // TODO: Error handling
                }
            }
        }
    }
}
