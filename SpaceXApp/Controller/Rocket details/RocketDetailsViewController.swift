//
//  RocketDetailsViewController.swift
//  SpaceXApp
//
//  Created by Konstantin on 03.03.2021.
//  Copyright © 2021 Konstantin Akchurin. All rights reserved.
//

import UIKit

class RocketDetailsViewController: UIViewController {
    let rocketDetails: SpaceXRocket!
    var dataProvider: SpaceXDataProvider!
    var collectionView: UICollectionView!
    var imagePageControl: UIPageControl!
    
    init(rocketDetails: SpaceXRocket, dataProvider: SpaceXDataProvider) {
        self.rocketDetails = rocketDetails
        self.dataProvider = dataProvider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = rocketDetails.name ?? "Rocket name"
        view.backgroundColor = .white
        setupCollectionViewFlowLayout()
        addCollectionView()
        registerCollectionViewCells()
    }
    
    func registerCollectionViewCells() {
        collectionView.register(RocketSizeCollectionViewCell.self, forCellWithReuseIdentifier: RocketSizeCollectionViewCell.identifier)
        collectionView.register(TextCollectionViewCell.self, forCellWithReuseIdentifier: TextCollectionViewCell.identifier)
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        collectionView.register(CountryCollectionViewCell.self, forCellWithReuseIdentifier: CountryCollectionViewCell.identifier)
        collectionView.register(RocketStageCollectionViewCell.self, forCellWithReuseIdentifier: RocketStageCollectionViewCell.identifier)
        collectionView.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: "Header", withReuseIdentifier: HeaderCollectionReusableView.identifier)
        collectionView.register(RocketLaunchCostCollectionViewCell.self, forCellWithReuseIdentifier: RocketLaunchCostCollectionViewCell.identifier)
    }
    
    func setupCollectionViewFlowLayout() {
        collectionView = .init(frame: .zero, collectionViewLayout: RocketDetailsViewController.createLayout())
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
    }
    
    func addCollectionView() {
        view.addSubview(collectionView)
        collectionView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
    }
    
    static func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            let layoutProvider = RocketDetailsSectionLayoutProvider(environment: env)
            switch sectionNumber {
            case 0:
                return layoutProvider.layoutSection(section: .imagesSlider)
            case 1:
                return layoutProvider.layoutSection(section: .rocketDescription)
            case 2:
                return layoutProvider.layoutSection(section: .rocketSize)
            case 3:
                return layoutProvider.layoutSection(section: .rocketCountry)
            case 4:
                return layoutProvider.layoutSection(section: .firstStage)
            case 5:
                return layoutProvider.layoutSection(section: .secondStage)
            case 6:
                return layoutProvider.layoutSection(section: .costPerLaunch)
            default:
                return layoutProvider.layoutSection(section: .defaultSection)
            }
        }
    }
}

extension RocketDetailsViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return rocketDetails.flickrImages.count
        case 1:
            return 1
        case 2:
            return 1
        case 3:
            return 1
        case 4:
            return 1
        case 5:
            return 1
        case 6:
            return 1
        default:
            return 0
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as! ImageCollectionViewCell
            if let imageURL = rocketDetails.flickrImages[indexPath.row] {
                dataProvider.downloadImage(url: imageURL) { (result) in
                    switch result {
                    case .success(let image):
                        DispatchQueue.main.async {
                            cell.imageView.image = image
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TextCollectionViewCell.identifier, for: indexPath) as! TextCollectionViewCell
            cell.textLabel.text = rocketDetails.description ?? "N/A"
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RocketSizeCollectionViewCell.identifier, for: indexPath) as! RocketSizeCollectionViewCell
            cell.heightValueLabel.text = "\(rocketDetails.height?.meters ?? 0.0) m"
            cell.massValueLabel.text = "\(rocketDetails.mass?.kg ?? 0.0) kg"
            cell.diameterValueLabel.text = "\(rocketDetails.diameter?.meters ?? 0.0) m"
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CountryCollectionViewCell.identifier, for: indexPath) as! CountryCollectionViewCell
            cell.countryNameLabel.text = rocketDetails.country ?? "N/A"
            if rocketDetails.country == "United States" {
                cell.countryFlagLabel.text = "🇺🇸"
            } else if rocketDetails.country == "Republic of the Marshall Islands" {
                cell.countryFlagLabel.text = "🇲🇭"
            }
            return cell
        case 4:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RocketStageCollectionViewCell.identifier, for: indexPath) as! RocketStageCollectionViewCell
            cell.enginesValueLabel.text = "\(rocketDetails.firstStage?.engines ?? 0)"
            cell.burnTimeValueLabel.text = "\(rocketDetails.firstStage?.burnTimeSec ?? 0) seconds"
            cell.fuelAmountValueLabel.text = "\(rocketDetails.firstStage?.fuelAmountTons ?? 0.0) tons"
            if let isReusable = rocketDetails.firstStage?.reusable {
                cell.reusableValueLabel.text = isReusable ? "Yes" : "No"
            }
            return cell
        case 5:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RocketStageCollectionViewCell.identifier, for: indexPath) as! RocketStageCollectionViewCell
            cell.enginesValueLabel.text = "\(rocketDetails.secondStage?.engines ?? 0)"
            cell.burnTimeValueLabel.text = "\(rocketDetails.secondStage?.burnTimeSec ?? 0) seconds"
            cell.fuelAmountValueLabel.text = "\(rocketDetails.secondStage?.fuelAmountTons ?? 0.0) tons"
            if let isReusable = rocketDetails.secondStage?.reusable {
                cell.reusableValueLabel.text = isReusable ? "Yes" : "No"
            }
            return cell
        case 6:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RocketLaunchCostCollectionViewCell.identifier, for: indexPath) as! RocketLaunchCostCollectionViewCell
            cell.moneyLabel.text = "$ \((rocketDetails.costPerLaunch ?? 0).formattedWithSeparator)"
            return cell
        default:
            return .init()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderCollectionReusableView.identifier, for: indexPath) as! HeaderCollectionReusableView
        switch indexPath.section {
        case 4:
            header.headerLabel.text = "Stage 1"
        case 5:
            header.headerLabel.text = "Stage 2"
        case 6:
            header.headerLabel.text = "Cost per launch"
        default:
            break
        }
        return header
    }
}
