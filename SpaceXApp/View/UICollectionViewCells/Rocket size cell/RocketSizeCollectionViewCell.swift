//
//  RocketSizeCollectionViewCell.swift
//  SpaceXApp
//
//  Created by Konstantin on 17.03.2021.
//  Copyright © 2021 Konstantin Akchurin. All rights reserved.
//

import UIKit

class RocketSizeCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupMainView()
        setupLeftStackView()
        setupRightStackView()
        fillLeftStackView()
        fillRightStackView()
        setupShadows()
        mainView.layer.cornerRadius = 12.0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class var identifier: String {
        return String(describing: self)
    }
    
    let mainView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(named: "cellBackground")
        return view
    }()
    
    let leftStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        return stackView
    }()
    
    let rightStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        return stackView
    }()
    
    let heightNameLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.text = "Height"
        label.setContentHuggingPriority(UILayoutPriority(252), for: .horizontal)
        return label
    }()
    
    let diameterNameLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.text = "Diameter"
        label.setContentHuggingPriority(UILayoutPriority(252), for: .horizontal)
        return label
    }()
    
    let massNameLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.text = "Mass"
        label.setContentHuggingPriority(UILayoutPriority(252), for: .horizontal)
        return label
    }()
    
    let heightValueLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.text = "100000000"
        label.setContentHuggingPriority(UILayoutPriority(251), for: .horizontal)
        return label
    }()
    
    let diameterValueLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.text = "100000000"
        label.setContentHuggingPriority(UILayoutPriority(251), for: .horizontal)
        return label
    }()
    
    let massValueLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.text = "100000000"
        label.setContentHuggingPriority(UILayoutPriority(251), for: .horizontal)
        return label
    }()
    
    func setupMainView() {
        contentView.addSubview(mainView)
        mainView.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor)
    }
    
    private func setupLeftStackView() {
        mainView.addSubview(leftStackView)
        leftStackView.anchor(top: mainView.topAnchor, leading: mainView.leadingAnchor, bottom: mainView.bottomAnchor, trailing: nil, padding: .init(top: .zero, left: 16, bottom: .zero, right: .zero))
    }
    
    private func setupRightStackView() {
        mainView.addSubview(rightStackView)
        rightStackView.anchor(top: mainView.topAnchor, leading: leftStackView.trailingAnchor, bottom: mainView.bottomAnchor, trailing: mainView.trailingAnchor, padding: .init(top: .zero, left: 32, bottom: .zero, right: .zero))
    }
    
    private func fillLeftStackView() {
        leftStackView.addArrangedSubview(heightNameLabel)
        leftStackView.addArrangedSubview(diameterNameLabel)
        leftStackView.addArrangedSubview(massNameLabel)
    }
    
    private func fillRightStackView() {
        rightStackView.addArrangedSubview(heightValueLabel)
        rightStackView.addArrangedSubview(diameterValueLabel)
        rightStackView.addArrangedSubview(massValueLabel)
    }
    
    private func setupShadows() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = .zero
        layer.shadowRadius = 15
    }
}
