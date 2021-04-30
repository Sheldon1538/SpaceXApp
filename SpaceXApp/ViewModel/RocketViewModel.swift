//
//  RocketViewModel.swift
//  SpaceXApp
//
//  Created by Konstantin on 23.04.2021.
//  Copyright © 2021 Konstantin Akchurin. All rights reserved.
//

import Foundation

final class RocketViewModel: ViewModelImageRepresentable {
    private let rocket: SpaceXRocket
    
    private let apiService: APIClient
    
    private let imageCache = NSCache<NSString, NSData>()
    
    var secondStage: SpaceXRocketSecondStage? {
        return rocket.secondStage
    }
    
    var images: [String?] {
        return rocket.flickrImages
    }
    
    var costPerLaunch: String {
        return "$ \((rocket.costPerLaunch ?? 0).formattedWithSeparator)"
    }
    
    var country: String {
        return rocket.country ?? "N/A"
    }
    
    var height: String {
        return "\(rocket.height?.meters ?? 0.0) m"
    }
    
    var diameter: String {
        return "\(rocket.diameter?.meters ?? 0.0) m"
    }
    
    var mass: String {
        return "\(rocket.mass?.kg ?? 0.0) kg"
    }
    
    var rocketName: String {
        return rocket.name ?? "N/A"
    }
    
    var engines: String {
        return "\(rocket.engines?.number ?? 0) engines"
    }
    
    var firstLaunchDate: String {
        return Date().getDateStringInDisplayFormat(utcString: rocket.firstFlight ?? "N/A", format: DateFormats.spaceXRocketFirstLaunch) ?? "N/A"
    }
    
    var rocketDescription: String {
        return rocket.description ?? "N/A"
    }
    
    var firstStage: SpaceXRocketFirstStage? {
        return rocket.firstStage
    }
    
    var countryFlag: String {
        if country == "United States" {
            return "🇺🇸"
        } else if country == "Republic of the Marshall Islands" {
            return "🇲🇭"
        }
        return ""
    }
    
    
    init(rocket: SpaceXRocket, apiService: APIClient) {
        self.rocket = rocket
        self.apiService = apiService
    }
    
    func loadImageData(url: String, completion: @escaping(Data) -> Void) {
        if let imageDataFromCache = imageCache.object(forKey: NSString(string: url)) {
            completion(imageDataFromCache as Data)
        } else {
            apiService.loadData(url: url) { (result) in
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
