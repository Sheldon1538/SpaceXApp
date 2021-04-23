//
//  RocketViewModel.swift
//  SpaceXApp
//
//  Created by Konstantin on 23.04.2021.
//  Copyright © 2021 Konstantin Akchurin. All rights reserved.
//

import Foundation

final class RocketViewModel {
    var secondStage: SpaceXRocketSecondStage?
    var images: [String?]
    var costPerLaunch: String
    var country: String
    var height: String
    var diameter: String
    var mass: String
    var rocketName: String
    var engines: String
    var firstLaunchDate: String
    var rocketDescription: String
    var firstStage: SpaceXRocketFirstStage?
    var countryFlag: String = ""
    
    private let networkService: APIManager
    var imageCache = NSCache<NSString, NSData>()
    
    init(rocket: SpaceXRocket, networkService: APIManager) {
        self.rocketName = rocket.name ?? "N/A"
        self.engines = "\(rocket.engines?.number ?? 0) engines"
        self.firstLaunchDate =  Date().getDateStringInDisplayFormat(utcString: rocket.firstFlight ?? "N/A", format: DateFormats.spaceXRocketFirstLaunch) ?? "N/A"
        self.rocketDescription = rocket.description ?? "N/A"
        self.firstStage = rocket.firstStage
        self.height = "\(rocket.height?.meters ?? 0.0) m"
        self.diameter = "\(rocket.diameter?.meters ?? 0.0) m"
        self.mass = "\(rocket.mass?.kg ?? 0.0) kg"
        self.country = rocket.country ?? "N/A"
        self.costPerLaunch = "$ \((rocket.costPerLaunch ?? 0).formattedWithSeparator)"
        self.images = rocket.flickrImages
        self.secondStage = rocket.secondStage
        if country == "United States" {
            countryFlag = "🇺🇸"
        } else if country == "Republic of the Marshall Islands" {
            countryFlag = "🇲🇭"
        }
        self.networkService = networkService
    }
    
    func loadImageData(url: String, completion: @escaping(Data) -> Void) {
        if let imageDataFromCache = imageCache.object(forKey: NSString(string: url)) {
            completion(imageDataFromCache as Data)
        } else {
            networkService.loadData(urlString: url) { (result) in
                switch result {
                case .success(let data):
                    self.imageCache.setObject(data as NSData, forKey: NSString(string: url))
                    completion(data)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
