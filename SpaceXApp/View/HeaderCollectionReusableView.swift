//
//  HeaderCollectionReusableView.swift
//  SpaceXApp
//
//  Created by Konstantin on 18.03.2021.
//  Copyright © 2021 Konstantin Akchurin. All rights reserved.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHeaderLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class var identifier: String {
        return String(describing: self)
    }
    
    let headerLabel: UILabel = {
       let label = UILabel()
        label.textColor = UIColor(named: "headerText")
        label.font = .systemFont(ofSize: 16, weight: .heavy)
        return label
    }()
    
    private func setupHeaderLabel() {
        addSubview(headerLabel)
        headerLabel.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: .zero, left: 8, bottom: .zero, right: .zero))
        headerLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
