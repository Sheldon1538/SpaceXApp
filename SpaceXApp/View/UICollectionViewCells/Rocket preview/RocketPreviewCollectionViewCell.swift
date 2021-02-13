//
//  RocketPreviewCollectionViewCell.swift
//  SpaceXApp
//
//  Created by Konstantin on 05.02.2021.
//  Copyright © 2021 Konstantin Akchurin. All rights reserved.
//

import UIKit

class RocketPreviewCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupRocketImageView()
        setupRocketDetailsBackgroundView()
        setupRocketDetailsStackView()
        addShadow(to: rocketDetailsBackgroundView)
        
        contentView.bringSubviewToFront(rocketImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class var identifier: String {
        return String(describing: self)
    }
    
    let rocketNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .black)
        return label
    }()
    
    let rocketDescriptionLabel: DetailedInfoLabel = {
       let label = DetailedInfoLabel()
        label.numberOfLines = 4
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    
    let rocketEnginesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 0.9451864844, green: 0.7608078703, blue: 0.6433241656, alpha: 0.85)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    let firstLaunchLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    let rocketImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .white
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16.0
        return imageView
    }()
    
    let rocketDetailsBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 8.0
        return view
    }()
    
    let rocketDetailsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    private func setupRocketImageView() {
        contentView.addSubview(rocketImageView)
        rocketImageView.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: nil, size: .init(width: 130, height: 170))
    }
    
    private func setupRocketDetailsBackgroundView() {
        contentView.addSubview(rocketDetailsBackgroundView)
        rocketDetailsBackgroundView.anchor(top: rocketImageView.topAnchor, leading: rocketImageView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor, padding: .init(top: 16.0, left: 16.0, bottom: 0.0, right: 0.0))
    }
    
    private func setupRocketDetailsStackView() {
        contentView.addSubview(rocketDetailsStackView)
        rocketDetailsStackView.anchor(top: rocketDetailsBackgroundView.topAnchor, leading: rocketImageView.trailingAnchor, bottom: rocketDetailsBackgroundView.bottomAnchor, trailing: rocketDetailsBackgroundView.trailingAnchor, padding: .init(top: 8.0, left: 16.0, bottom: 16.0, right: 16.0))
        rocketDetailsStackView.addArrangedSubview(rocketNameLabel)
        rocketDetailsStackView.addArrangedSubview(rocketEnginesLabel)
        rocketDetailsStackView.addArrangedSubview(firstLaunchLabel)
        rocketDetailsStackView.addArrangedSubview(rocketDescriptionLabel)
    }
    
    private func addShadow(to view: UIView) {
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.15
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 10
    }
}
