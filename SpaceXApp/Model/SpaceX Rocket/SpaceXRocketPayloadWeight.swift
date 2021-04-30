//
//  SpaceXRocketPayloadWeight.swift
//  SpaceXApp
//
//  Created by Konstantin on 13.02.2021.
//  Copyright © 2021 Konstantin Akchurin. All rights reserved.
//

import Foundation

struct SpaceXRocketPayloadWeight: Decodable {
    var id: String?
    var name: String?
    var kg: Int?
    var lb: Int?
}
