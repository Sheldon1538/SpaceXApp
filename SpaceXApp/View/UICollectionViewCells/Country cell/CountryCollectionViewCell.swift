//
//  CountryCollectionViewCell.swift
//  SpaceXApp
//
//  Created by Konstantin on 17.03.2021.
//  Copyright © 2021 Konstantin Akchurin. All rights reserved.
//

import UIKit

class CountryCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCountryFlagLabel()
        setupCountryNameLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class var identifier: String {
        return String(describing: self)
    }
    
    let countryFlagLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25, weight: .regular)
        label.text = "🇺🇸"
        return label
    }()
    
    let countryNameLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.8)
        label.text = "United States"
        return label
    }()

    
    private func setupCountryFlagLabel() {
        contentView.addSubview(countryFlagLabel)
        countryFlagLabel.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: nil)
    }
    
    private func setupCountryNameLabel() {
        contentView.addSubview(countryNameLabel)
        countryNameLabel.anchor(top: contentView.topAnchor, leading: countryFlagLabel.trailingAnchor, bottom: contentView.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 8, bottom: 0, right: 0))
    }
}
