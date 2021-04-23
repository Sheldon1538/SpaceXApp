//
//  LaunchViewModel.swift
//  SpaceXApp
//
//  Created by Konstantin on 22.04.2021.
//  Copyright © 2021 Konstantin Akchurin. All rights reserved.
//

import Foundation

final class LaunchViewModel {
    private let launch: SpaceXLaunch
    
    var imageURL: String {
        return launch.links?.missionPatchSmall ?? ""
    }
    
    var flightNumber: String {
        return "\(launch.flightNumber ?? 0)"
    }
    
    var details: String {
        return launch.details ?? "No details provided"
    }
    
    var missionName: String {
        return launch.missionName ?? "N/A"
    }
    
    var rocketName: String {
        return launch.rocket?.rocketName ?? "N/A"
    }
    
    var date: String {
        return Date().getDateStringInDisplayFormat(utcString: launch.launchDateUtc ?? "N/A", format: DateFormats.spaceXLaunch) ?? "N/A"
    }
    
    var siteName: String {
        return launch.launchSite?.siteName ?? "N/A"
    }
    
    var result: String {
        if launch.upcoming ?? false {
            return "Upcoming launch"
        } else {
            return launch.launchSuccess ?? false ? "Successful launch" : "Failed launch"
        }
    }
    
    init(launch: SpaceXLaunch) {
        self.launch = launch
    }
}
