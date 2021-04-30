//
//  SpaceXLaunchV4.swift
//  SpaceXApp
//
//  Created by Konstantin on 27.04.2021.
//  Copyright © 2021 Konstantin Akchurin. All rights reserved.
//

import Foundation

struct SpaceXLaunchV4: Decodable {
    var docs: [SpaceXLaunchV4Doc]?
    var totalDocs: Int?
    var limit: Int?
    var totalPages: Int?
    var page: Int?
    var pagingCounter: Int?
    var hasPrevPage: Bool?
    var hasNextPage: Bool?
    var prevPage: Int?
    var nextPage: Int?
}
