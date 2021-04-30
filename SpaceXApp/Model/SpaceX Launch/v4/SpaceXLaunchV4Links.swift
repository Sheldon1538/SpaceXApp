//
//  SpaceXLaunchV4Links.swift
//  SpaceXApp
//
//  Created by Konstantin on 27.04.2021.
//  Copyright © 2021 Konstantin Akchurin. All rights reserved.
//

import Foundation

struct SpaceXLaunchV4Links: Decodable {
    var patch: SpaceXV4Patch?
    var reddit: SpaceXV4Reddit?
    var flickr: SpaceXV4Flickr?
    var presskit: String?
    var webcast: String?
    var youtube_id: String?
    var article: String?
    var wikipedia: String?
}
