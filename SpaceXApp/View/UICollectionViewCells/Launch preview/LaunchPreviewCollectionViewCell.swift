//
//  LaunchPreviewCollectionViewCell.swift
//  SpaceXApp
//
//  Created by Konstantin on 15/03/2020.
//  Copyright © 2020 Konstantin Akchurin. All rights reserved.
//

import UIKit

class LaunchPreviewCollectionViewCell: UICollectionViewCell {
    
    var imageUrl = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupShadows()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        rocketImageView.image = nil
    }
    
    class var identifier: String {
        return String(describing: self)
    }
    
    let missionNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .black)
        return label
    }()
    
    let rocketImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let separator: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.2)
        return view
    }()
    
    let launchInfoStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    let launchDetailsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    let rocketNameLabel = DetailedInfoLabel()
    let launchDateLabel = DetailedInfoLabel()
    let siteNameLabel: DetailedInfoLabel = {
        let label = DetailedInfoLabel()
        label.numberOfLines = 2
        return label
    }()
    let resultLabel = DetailedInfoLabel()
    
    private func setupView() {
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        layer.cornerRadius = 12.0
        setupMissionNameLabel()
        setupSeparator()
        setupLaunchInfoStackView()
        setupLaunchDetailsStackView()
    }
    
    func setupLaunchInfoStackView() {
        contentView.addSubview(launchInfoStackView)
        launchInfoStackView.addArrangedSubview(rocketImageView)
        launchInfoStackView.anchor(top: separator.bottomAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor, padding: .init(top: 8, left: 16, bottom: 8, right: 16))
    }
    
    func setupLaunchDetailsStackView() {
        launchInfoStackView.addArrangedSubview(launchDetailsStackView)
        launchDetailsStackView.addArrangedSubview(rocketNameLabel)
        launchDetailsStackView.addArrangedSubview(launchDateLabel)
        launchDetailsStackView.addArrangedSubview(siteNameLabel)
        launchDetailsStackView.addArrangedSubview(resultLabel)
    }
    
    func setupMissionNameLabel() {
        contentView.addSubview(missionNameLabel)
        missionNameLabel.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(top: 16, left: 16, bottom: 0, right: 16))
    }
    
    func setupSeparator() {
        contentView.addSubview(separator)
        separator.anchor(top: missionNameLabel.bottomAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(top: 8, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 1))
    }
    
    private func setupShadows() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0.0)
        layer.shadowRadius = 8.0
        layer.shadowOpacity = 0.07
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
    }
    
    func configureWith(data: LaunchViewModel) {
        imageUrl              = data.imageURL
        missionNameLabel.text = data.missionName
        rocketNameLabel.text  = data.rocketName
        siteNameLabel.text    = data.siteName
        launchDateLabel.text  = data.date
        resultLabel.text      = data.result
    }
}
