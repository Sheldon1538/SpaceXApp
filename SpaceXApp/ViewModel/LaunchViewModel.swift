//
//  LaunchViewModel.swift
//  SpaceXApp
//
//  Created by Konstantin on 22.04.2021.
//  Copyright © 2021 Konstantin Akchurin. All rights reserved.
//

import Foundation

protocol LaunchViewModelProtocol {
    var missionName: String { get }
    var rocketName: String { get }
    var date: String { get }
    var siteName: String { get }
    var result: String { get }
    var details: String { get }
    var flightNumber: String { get }
    var imageURL: String { get }
}

final class LaunchViewModel: LaunchViewModelProtocol {
    var imageURL: String
    var flightNumber: String
    var details: String
    var missionName: String
    var rocketName: String
    var date: String
    var siteName: String
    var result: String
    
    init(launch: SpaceXLaunch) {
        self.missionName  = launch.missionName ?? "N/A"
        self.rocketName   = launch.rocket?.rocketName ?? "N/A"
        self.siteName     = launch.launchSite?.siteName ?? "N/A"
        if launch.upcoming ?? false {
            self.result = "Upcoming launch"
        } else {
            self.result       = launch.launchSuccess ?? false ? "Successful launch" : "Failed launch"
        }
        self.date         = Date().getDateStringInDisplayFormat(utcString: launch.launchDateUtc ?? "N/A", format: DateFormats.spaceXLaunch) ?? "N/A"
        self.details      = launch.details ?? "No details provided"
        self.flightNumber = "\(launch.flightNumber ?? 0)"
        self.imageURL     = launch.links?.missionPatchSmall ?? ""
        
    }
}
