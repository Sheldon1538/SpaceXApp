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
    
    class var identifier: String {
        return String(describing: self)
    }
    
    class var nibName: String {
        return String(describing: self)
    }
    
    let mainView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let nameLabel: UILabel = {
       let label = UILabel()
        label.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 1000), for: .horizontal)
        label.font = UIFont.systemFont(ofSize: 16.0, weight: .semibold)
        return label
    }()
    
    let valueLabel: UILabel = {
       let label = UILabel()
        label.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 999), for: .horizontal)
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16.0, weight: .regular)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addMainView()
        addNameLabel()
        addValueLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addMainView() {
        contentView.addSubview(mainView)
        mainView.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor)
        mainView.heightAnchor.constraint(greaterThanOrEqualToConstant: 60).isActive = true
    }
    
    func addNameLabel() {
        mainView.addSubview(nameLabel)
        nameLabel.anchor(top: nil, leading: mainView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0.0, left: 16.0, bottom: 0.0, right: 0.0), size: .zero)
        nameLabel.centerYAnchor.constraint(equalTo: mainView.centerYAnchor).isActive = true
    }
    
    func addValueLabel() {
        mainView.addSubview(valueLabel)
        valueLabel.anchor(top: mainView.topAnchor, leading: nil, bottom: mainView.bottomAnchor, trailing: mainView.trailingAnchor, padding: .init(top: 16.0, left: 0.0, bottom: 16.0, right: 16.0), size: .zero)
        valueLabel.centerYAnchor.constraint(equalTo: mainView.centerYAnchor).isActive = true
        valueLabel.leadingAnchor.constraint(greaterThanOrEqualTo: nameLabel.trailingAnchor, constant: 16.0).isActive = true
    }
    
    func configureWith(data: LaunchViewModel, row: Int) {
        switch row {
        case 0:
            nameLabel.text = "Details"
            valueLabel.text = data.details
        case 1:
            nameLabel.text = "Launch site"
            valueLabel.text = data.launchpadName
        case 2:
            nameLabel.text = "Flight number"
            valueLabel.text = data.flightNumber
        case 3:
            nameLabel.text = "Rocket name"
            valueLabel.text = data.rocketName
        case 4:
            nameLabel.text = "Result"
            valueLabel.text = data.result
        default:
            break
        }
    }
    
}
