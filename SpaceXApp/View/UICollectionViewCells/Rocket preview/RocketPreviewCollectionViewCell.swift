//
//  RocketPreviewCollectionViewCell.swift
//  SpaceXApp
//
//  Created by Konstantin on 05.02.2021.
//  Copyright © 2021 Konstantin Akchurin. All rights reserved.
//

import UIKit

class RocketPreviewCollectionViewCell: UICollectionViewCell {
    var imageURL: String!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupRocketImageView()
        setupRocketDetailsBackgroundView()
        setupRocketDetailsStackView()
        addShadow(to: rocketDetailsBackgroundView)
        contentView.bringSubviewToFront(rocketImageView)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        rocketImageView.image = nil
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
        label.textColor = UIColor(named: "cellTitle")
        label.font = UIFont.systemFont(ofSize: 18, weight: .black)
        return label
    }()
    
    let rocketDescriptionLabel: DetailedInfoLabel = {
       let label = DetailedInfoLabel()
        label.numberOfLines = 4
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    
    let rocketEnginesLabel: PaddingLabel = {
        let label = PaddingLabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.backgroundColor = #colorLiteral(red: 0.9451864844, green: 0.3631296346, blue: 0, alpha: 0.5)
        label.textColor = .white
        label.textAlignment = .left
        label.contentMode = .left
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 8.0
        return label
    }()
    
    let firstLaunchLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = UIColor(named: "cellTitle")
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    let rocketImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .lightGray
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16.0
        return imageView
    }()
    
    let rocketDetailsBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "cellBackground")
        view.layer.cornerRadius = 8.0
        return view
    }()
    
    let rocketDetailsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillProportionally
        stackView.alignment = .leading
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
