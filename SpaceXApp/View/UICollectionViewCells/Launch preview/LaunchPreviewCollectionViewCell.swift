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
        label.minimumScaleFactor = 0.7
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
        missionNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        missionNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        missionNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        // Separator.
        separator.topAnchor.constraint(equalTo: missionNameLabel.bottomAnchor, constant: 8).isActive = true
        separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        separator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        // Stackview.
        launchInfoStackView.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 8).isActive = true
        launchInfoStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        launchInfoStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        launchInfoStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
    }
    
    private func setupShadows() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0.0)
        layer.shadowRadius = 8.0
        layer.shadowOpacity = 0.07
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
    }
    
    public func configureWith(data: SpaceXLaunch) {
        missionNameLabel.text = data.missionName ?? "No data"
        rocketNameLabel.text  = data.rocket?.rocketName ?? "No rocket name information"
        siteNameLabel.text    = data.launchSite?.siteNameLong ?? "No site name information"
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = DateFormats.apiDateFormat
    
        if let date = dateFormatter.date(from: data.launchDateUtc ?? "") {
            let compactDateFormatter = DateFormatter()
            compactDateFormatter.locale = Locale.current
            compactDateFormatter.dateFormat = DateFormats.displayDateFormat
            launchDateLabel.text = "\(compactDateFormatter.string(from: date))"
        }
        
        if data.upcoming == true {
            resultLabel.text = "Upcoming launch"
        } else {
            if let result = data.launchSuccess {
                switch result {
                case true:
                    resultLabel.text = "Successful launch"
                case false:
                    resultLabel.text = "Failed launch"
                }
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
