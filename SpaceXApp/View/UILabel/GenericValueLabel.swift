//
//  GenericValueLabel.swift
//  SpaceXApp
//
//  Created by Konstantin on 18.03.2021.
//  Copyright © 2021 Konstantin Akchurin. All rights reserved.
//

import UIKit

class GenericValueLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        font = UIFont.systemFont(ofSize: 14, weight: .regular)
        textColor = .black
        text = "N/A"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
