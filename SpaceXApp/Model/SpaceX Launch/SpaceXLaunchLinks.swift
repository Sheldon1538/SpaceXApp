//
//  SpaceXLaunchLinks.swift
//  SpaceXApp
//
//  Created by Konstantin on 14/03/2020.
//  Copyright © 2020 Konstantin Akchurin. All rights reserved.
//

import Foundation

struct SpaceXLaunchLinks: Codable {
    let missionPatch:      String?
    let missionPatchSmall: String?
    let redditCampaign:    String?
    let redditLaunch:      String?
    let redditRecovery:    String?
    let redditMedia:       String?
    let presskit:          String?
    let articleLink:       String?
    let wikipedia:         String?
    let videoLink:         String?
    let youtubeID:         String?
    let flickrImages:      [String?]
    
    enum CodingKeys: String, CodingKey {
        case missionPatch      = "mission_patch"
        case missionPatchSmall = "mission_patch_small"
        case redditCampaign    = "reddit_campaign"
        case redditLaunch      = "reddit_launch"
        case redditRecovery    = "reddit_recovery"
        case redditMedia       = "reddit_media"
        case presskit          = "presskit"
        case articleLink       = "article_link"
        case wikipedia         = "wikipedia"
        case videoLink         = "video_link"
        case youtubeID         = "youtube_id"
        case flickrImages      = "flickr_images"
    }
}
