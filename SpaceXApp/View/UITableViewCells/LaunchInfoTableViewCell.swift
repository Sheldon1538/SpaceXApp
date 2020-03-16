//
//  LaunchInfoTableViewCell.swift
//  SpaceXApp
//
//  Created by Konstantin on 16/03/2020.
//  Copyright © 2020 Konstantin Akchurin. All rights reserved.
//

import Foundation
import UIKit

class LaunchInfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    
    class var identifier: String {
        return String(describing: self)
    }
    
    class var nibName: String {
        return String(describing: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureWith(data: SpaceXLaunch, row: Int) {
        switch row {
        case 0:
            nameLabel.text = "Details"
            valueLabel.text = data.details ?? "No details provided"
        case 1:
            nameLabel.text = "Launch site"
            valueLabel.text = data.launchSite?.siteNameLong ?? "No data"
        case 2:
            nameLabel.text = "Flight number"
            if let flightNumber = data.flightNumber {
                valueLabel.text = "\(flightNumber)"
            } else {
                valueLabel.text = "No data"
            }
        case 3:
            nameLabel.text = "Rocket name"
            valueLabel.text = data.rocket?.rocketName ?? "No data"
        case 4:
            nameLabel.text = "Result"
            if data.upcoming == true {
                valueLabel.text = "Upcoming launch"
            } else {
                if let result = data.launchSuccess {
                    valueLabel.text = result ? "Success" : "Failed"
                }
            }
        default:
            break
        }
    }
    
}
