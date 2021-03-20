//
//  RocketStageCollectionViewCell.swift
//  SpaceXApp
//
//  Created by Konstantin on 18.03.2021.
//  Copyright © 2021 Konstantin Akchurin. All rights reserved.
//

import UIKit

class RocketStageCollectionViewCell: UICollectionViewCell {
    var enginesNameLabel: GenericNameLabel!
    var fuelAmountNameLabel: GenericNameLabel!
    var burnTimeNameLabel: GenericNameLabel!
    var reusableNameLabel: GenericNameLabel!
    
    var enginesValueLabel: GenericValueLabel!
    var fuelAmountValueLabel: GenericValueLabel!
    var burnTimeValueLabel: GenericValueLabel!
    var reusableValueLabel: GenericValueLabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupMainView()
        setupNameLabels()
        setupValueLabel()
        setupLeftStackView()
        setupRightStackView()
        fillLeftStackView()
        fillRightStackView()
        setupShadows()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let mainView: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12.0
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
        
    private func setupMainView() {
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
    
    private func setupNameLabels() {
        enginesNameLabel = .init()
        enginesNameLabel.setContentHuggingPriority(UILayoutPriority(252), for: .horizontal)
        enginesNameLabel.text = "Stage engines"
        
        fuelAmountNameLabel = .init()
        fuelAmountNameLabel.setContentHuggingPriority(UILayoutPriority(252), for: .horizontal)
        fuelAmountNameLabel.text = "Fuel amount"
        
        burnTimeNameLabel = .init()
        burnTimeNameLabel.setContentHuggingPriority(UILayoutPriority(252), for: .horizontal)
        burnTimeNameLabel.text = "Burn time"
        
        reusableNameLabel = .init()
        reusableNameLabel.setContentHuggingPriority(UILayoutPriority(252), for: .horizontal)
        reusableNameLabel.text = "Stage is reusable"
    }
    
    private func setupValueLabel() {
        enginesValueLabel = .init()
        enginesValueLabel.setContentHuggingPriority(UILayoutPriority(251), for: .horizontal)
        fuelAmountValueLabel = .init()
        fuelAmountValueLabel.setContentHuggingPriority(UILayoutPriority(251), for: .horizontal)
        burnTimeValueLabel = .init()
        burnTimeValueLabel.setContentHuggingPriority(UILayoutPriority(251), for: .horizontal)
        reusableValueLabel = .init()
        reusableValueLabel.setContentHuggingPriority(UILayoutPriority(251), for: .horizontal)
    }
    
    private func fillLeftStackView() {
        leftStackView.addArrangedSubview(enginesNameLabel)
        leftStackView.addArrangedSubview(fuelAmountNameLabel)
        leftStackView.addArrangedSubview(burnTimeNameLabel)
        leftStackView.addArrangedSubview(reusableNameLabel)
    }
    
    private func fillRightStackView() {
        rightStackView.addArrangedSubview(enginesValueLabel)
        rightStackView.addArrangedSubview(fuelAmountValueLabel)
        rightStackView.addArrangedSubview(burnTimeValueLabel)
        rightStackView.addArrangedSubview(reusableValueLabel)
    }
    
    private func setupShadows() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = .zero
        layer.shadowRadius = 15
    }
}

