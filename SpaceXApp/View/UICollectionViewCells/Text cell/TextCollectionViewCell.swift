//
//  TextCollectionViewCell.swift
//  SpaceXApp
//
//  Created by Konstantin on 16.03.2021.
//  Copyright © 2021 Konstantin Akchurin. All rights reserved.
//

import UIKit

class TextCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTextLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class var identifier: String {
        return String(describing: self)
    }
    
    let textLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.textColor = UIColor(named: "cellTitle")
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func setupTextLabel() {
        contentView.addSubview(textLabel)
        textLabel.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor, padding: .init(top: 0, left: 32, bottom: 0, right: 32))
    }
}
