//
//  RocketLaunchCostCollectionViewCell.swift
//  SpaceXApp
//
//  Created by Konstantin on 21.03.2021.
//  Copyright © 2021 Konstantin Akchurin. All rights reserved.
//

import UIKit

class RocketLaunchCostCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupMoneyLabel()
        
        backgroundColor = #colorLiteral(red: 0.9254091382, green: 0.9255421162, blue: 0.9253800511, alpha: 0.35)
        layer.cornerRadius = 12.0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let moneyLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .heavy) // UIFont.init(name: "AvenirNext-Heavy", size: 22)
        label.textColor = .black
        return label
    }()
    
    private func setupMoneyLabel() {
        contentView.addSubview(moneyLabel)
        moneyLabel.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor, padding: .init(top: .zero, left: 16, bottom: .zero, right: .zero))
    }
}

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        return formatter
    }()
}

extension Numeric {
    var formattedWithSeparator: String { Formatter.withSeparator.string(for: self) ?? "" }
}
