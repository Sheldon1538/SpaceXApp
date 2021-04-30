//
//  LaunchesViewModel.swift
//  SpaceXApp
//
//  Created by Konstantin on 18.04.2021.
//  Copyright © 2021 Konstantin Akchurin. All rights reserved.
//

import Foundation

protocol LaunchesViewModelProtocol: ViewModelImageRepresentable, AnyObject {
    var  didUpdateLaunches: (([LaunchViewModel]) -> Void)? { get set }
    func didScrollAllLaunches()
}

protocol ViewModelImageRepresentable {
    func loadImageData(url: String, completion: @escaping(Data) -> Void)
}

final class LaunchesViewModel: LaunchesViewModelProtocol {
    var didUpdateLaunches: (([LaunchViewModel]) -> Void)?
    
    private var spaceXLaunches: [SpaceXLaunchV4Doc] = [] {
        didSet {
            loadRocketAndLaunchpadNames { (models) in
                self.didUpdateLaunches?(models)
            }
        }
    }
    
    var loadedAllLaunches = false
    
    private let apiService: APIClient
    private var imageDataCache = NSCache<NSString, NSData>()
    private var launchPaginationOffset = 0
    
    init(apiService: APIClient) {
        self.apiService = apiService
    }
    
    private func loadLaunches() {
        let request = SpaceXAPIQueryLaunches(offset: launchPaginationOffset)
        apiService.send(request) { (result) in
            switch result {
            case .success(let launchesResponse):
                guard let launches = launchesResponse.docs else { return }
                if launches.isEmpty {
                    self.loadedAllLaunches = true
                } else {
                    self.launchPaginationOffset += launches.count
                    self.spaceXLaunches += launches
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func loadRocketAndLaunchpadNames(completion: @escaping([LaunchViewModel]) -> Void) {
        var models: [LaunchViewModel] = []
        let mainTaskGroup = DispatchGroup()
        for model in spaceXLaunches {
            mainTaskGroup.enter()
            let innerTaskGroup = DispatchGroup()
            innerTaskGroup.enter()
            // Task 1: loading rocket name.
            var tempRocketName = ""
            let rocketNameRequest = SpaceXAPIGetRocket(id: model.rocket ?? "N/A")
            apiService.send(rocketNameRequest) { (result) in
                switch result {
                case .success(let rocket):
                    tempRocketName = rocket.name ?? "N/A"
                case .failure(let error):
                    print(error)
                }
                innerTaskGroup.leave()
            }
            var tempLaunchpadName = ""
            // Task 2: loading launchpad name.
            innerTaskGroup.enter()
            let launchpadNameRequest = SpaceXAPIGetLaunchpad(id: model.launchpad ?? "N/A")
            apiService.send(launchpadNameRequest) { (result) in
                switch result {
                case .success(let launchpad):
                    tempLaunchpadName = launchpad.name ?? "N/A"
                case .failure(let error):
                    print(error)
                }
                innerTaskGroup.leave()
            }
            
            innerTaskGroup.notify(queue: .main) {
                let newModel = LaunchViewModel(launch: model, apiService: self.apiService, rocketName: tempRocketName, launchpadName: tempLaunchpadName)
                models.append(newModel)
                mainTaskGroup.leave()
            }
        }
        mainTaskGroup.notify(queue: .main) {
            completion(models)
        }
    }
    
    func didScrollAllLaunches() {
        if !loadedAllLaunches {
            loadLaunches()
        }
    }
    
    func loadImageData(url: String, completion: @escaping(Data) -> Void) {
        if let cachedImageData = imageDataCache.object(forKey: url as NSString) {
            completion(cachedImageData as Data)
        } else {
            apiService.loadData(url: url) { (result) in
                switch result {
                case .success(let data):
                    self.imageDataCache.setObject(data as NSData, forKey: url as NSString)
                    completion(data)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
