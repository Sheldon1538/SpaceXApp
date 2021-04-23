//
//  DetailedInfoLabel.swift
//  SpaceXApp
//
//  Created by Konstantin on 15/03/2020.
//  Copyright © 2020 Konstantin Akchurin. All rights reserved.
//

import Foundation
import UIKit

class DetailedInfoLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        textColor = UIColor(named: "cellDetails")
        font = UIFont.systemFont(ofSize: 14, weight: .heavy)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
