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
        textColor = #colorLiteral(red: 0.2863664329, green: 0.2646090984, blue: 0.2535416782, alpha: 1)
        font = UIFont.systemFont(ofSize: 14, weight: .heavy)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
