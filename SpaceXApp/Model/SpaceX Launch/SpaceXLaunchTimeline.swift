//
//  SpaceXLaunchTimeline.swift
//  SpaceXApp
//
//  Created by Konstantin on 14/03/2020.
//  Copyright © 2020 Konstantin Akchurin. All rights reserved.
//

import Foundation

struct SpaceXLaunchTimeline: Codable {
    let webcastLiftoff:           Int?
    let goForPropLoading:         Int?
    let rp1Loading:               Int?
    let stage1LoxLoading:         Int?
    let stage2LoxLoading:         Int?
    let engineChill:              Int?
    let prelaunchChecks:          Int?
    let propellantPressurization: Int?
    let goForLaunch:              Int?
    let ignition:                 Int?
    let liftoff:                  Int?
    let maxq:                     Int?
    let meco:                     Int?
    let stageSep:                 Int?
    let secondStageIgnition:      Int?
    let fairingDeploy:            Int?
    let firstStageBoostbackBurn:  Int?
    let firstStageEntryBurn:      Int?
    let firstStageLanding:        Int?
    let seco1:                    Int?
    let secondStageRestart:       Int?
    let seco2:                    Int?
    let payloadDeploy:            Int?
    
    enum CodingKeys: String, CodingKey {
        case webcastLiftoff           = "webcast_liftoff"
        case goForPropLoading         = "go_for_prop_loading"
        case rp1Loading               = "rp1_loading"
        case stage1LoxLoading         = "stage1_lox_loading"
        case stage2LoxLoading         = "stage2_lox_loading"
        case engineChill              = "engine_chill"
        case prelaunchChecks          = "prelaunch_checks"
        case propellantPressurization = "propellant_pressurization"
        case goForLaunch              = "go_for_launch"
        case ignition                 = "ignition"
        case liftoff                  = "liftoff"
        case maxq                     = "maxq"
        case meco                     = "meco"
        case stageSep                 = "stage_sep"
        case secondStageIgnition      = "second_stage_ignition"
        case fairingDeploy            = "fairing_deploy"
        case firstStageBoostbackBurn  = "first_stage_boostback_burn"
        case firstStageEntryBurn      = "first_stage_entry_burn"
        case firstStageLanding        = "first_stage_landing"
        case seco1                    = "seco-1"
        case secondStageRestart       = "second_stage_restart"
        case seco2                    = "seco-2"
        case payloadDeploy            = "payload_deploy"
    }
}
