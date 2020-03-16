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
        contentView.addSubview(missionNameLabel)
        contentView.addSubview(separator)
        contentView.addSubview(launchInfoStackView)
        // Launch info StackView.
        launchInfoStackView.addArrangedSubview(rocketImageView)
        launchInfoStackView.addArrangedSubview(launchDetailsStackView)
        // Launch details StackView.
        launchDetailsStackView.addArrangedSubview(rocketNameLabel)
        launchDetailsStackView.addArrangedSubview(launchDateLabel)
        launchDetailsStackView.addArrangedSubview(siteNameLabel)
        launchDetailsStackView.addArrangedSubview(resultLabel)
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        layer.cornerRadius = 12.0
        // Rocket name label.
        missionNameLabel.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(top: 16, left: 16, bottom: 0, right: 16))
        // Separator.
        separator.anchor(top: missionNameLabel.bottomAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(top: 8, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 1))
        // Stackview.
        launchInfoStackView.anchor(top: separator.bottomAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor, padding: .init(top: 8, left: 16, bottom: 8, right: 16))
    }
    
    private func setupShadows() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0.0)
        layer.shadowRadius = 8.0
        layer.shadowOpacity = 0.07
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
    }
    
    func configureWith(data: SpaceXLaunch) {
        missionNameLabel.text = data.missionName ?? "No data"
        rocketNameLabel.text  = data.rocket?.rocketName ?? "No rocket name information"
        siteNameLabel.text    = data.launchSite?.siteNameLong ?? "No site name information"
        if let utcString = data.launchDateUtc {
            if let displayDate = Date().getDateStringInDisplayFormat(utcString: utcString) {
                launchDateLabel.text = displayDate
            }
        }
        if data.upcoming == true {
            resultLabel.text = "Upcoming launch"
        } else {
            if let result = data.launchSuccess {
                resultLabel.text = result ? "Successful launch" : "Failed launch"
            }
        }
        if let imageURLString = data.links?.missionPatchSmall {
            imageUrl = imageURLString
            NetworkManager.shared.loadData(urlString: imageURLString) { (result) in
                switch result {
                case .success(let data):
                    guard let image = UIImage(data: data) else { return }
                    DispatchQueue.main.async {
                        if imageURLString == self.imageUrl {
                            self.rocketImageView.image = image
                        }
                    }
                case .failure(let error):
                    print("Error loading image: " + error.localizedDescription)
                }
            }
        }
    }
}
