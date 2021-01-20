//
//  SpaceXDataProvider.swift
//  SpaceXApp
//
//  Created by Konstantin on 17/03/2020.
//  Copyright © 2020 Konstantin Akchurin. All rights reserved.
//

import UIKit

protocol SpaceXService {
    func getSpaceXLaunches(paginationOffset: Int, completion: @escaping(Result<[SpaceXLaunch], Error>) -> Void)
    func downloadImage(url: String, completion: @escaping(Result<UIImage, Error>) -> Void)
}

class SpaceXDataProvider: SpaceXService {
    var apiManager: APIManager
    var imageCache = NSCache<NSString, UIImage>()
    
    init(apiManager: APIManager) {
        self.apiManager = apiManager
    }
    
    func getSpaceXLaunches(paginationOffset: Int, completion: @escaping(Result<[SpaceXLaunch], Error>) -> Void) {
        let url = SpaceXGetLaunchesURL(offset: paginationOffset).getURL()
        apiManager.fetch(url: url, type: [SpaceXLaunch].self) { (result) in
            switch result {
            case .success(let launches):
                completion(.success(launches))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func downloadImage(url: String, completion: @escaping(Result<UIImage, Error>) -> Void) {
        if let cachedImage = imageCache.object(forKey: url as NSString) {
            completion(.success(cachedImage))
        } else {
            apiManager.loadData(urlString: url) { (result) in
                switch result {
                case .success(let data):
                    guard let image = UIImage(data: data) else { return }
                    self.imageCache.setObject(image, forKey: url as NSString)
                    completion(.success(image))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
