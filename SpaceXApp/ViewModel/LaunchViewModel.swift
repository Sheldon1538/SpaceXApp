//
//  LaunchViewModel.swift
//  SpaceXApp
//
//  Created by Konstantin on 22.04.2021.
//  Copyright © 2021 Konstantin Akchurin. All rights reserved.
//

import Foundation

final class LaunchViewModel {
    private let launch: SpaceXLaunchV4Doc
    private let apiService: APIClient
    
    var imageURL: String {
        return launch.links?.patch?.small ?? ""
    }
    
    var flightNumber: String {
        return "\(launch.flight_number ?? 0)"
    }
    
    var details: String {
        return launch.details ?? "No details provided"
    }
    
    var missionName: String {
        return launch.name ?? "N/A"
    }
    
    var rocketName: String
    
    var date: String {
        return Date().getDateStringInDisplayFormat(utcString: launch.date_utc ?? "N/A", format: DateFormats.spaceXLaunch) ?? "N/A"
    }
    
    var launchpadName: String
    
    var result: String {
        if launch.upcoming ?? false {
            return "Upcoming launch"
        } else {
            return launch.success ?? false ? "Successful launch" : "Failed launch"
        }
    }
    
    init(launch: SpaceXLaunchV4Doc, apiService: APIClient, rocketName: String? = nil, launchpadName: String? = nil) {
        self.launch = launch
        self.apiService = apiService
        self.launchpadName = launchpadName ?? "N/A"
        self.rocketName = rocketName ?? "N/A"
    }
}
