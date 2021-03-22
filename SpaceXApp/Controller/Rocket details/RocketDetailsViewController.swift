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
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(RocketSizeCollectionViewCell.self, forCellWithReuseIdentifier: "RocketSizeCollectionViewCell")
        collectionView.register(TextCollectionViewCell.self, forCellWithReuseIdentifier: "TextCollectionViewCell")
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "ImageCollectionViewCell")
        collectionView.register(CountryCollectionViewCell.self, forCellWithReuseIdentifier: "CountryCollectionViewCell")
        collectionView.register(RocketStageCollectionViewCell.self, forCellWithReuseIdentifier: "RocketStageCollectionViewCell")
        collectionView.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: "Header", withReuseIdentifier: "HeaderCollectionReusableView")
        collectionView.register(RocketLaunchCostCollectionViewCell.self, forCellWithReuseIdentifier: "RocketLaunchCostCollectionViewCell")
    }
    
    func setupCollectionViewFlowLayout() {
        collectionView = .init(frame: .zero, collectionViewLayout: RocketDetailsViewController.createLayout())
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
            switch sectionNumber {
            case 0:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                item.contentInsets = .init(top: 8, leading: 8, bottom: 8, trailing: 8)
                let groupWidth = env.container.contentSize.width * 0.87
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(groupWidth), heightDimension: .absolute(250)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                let sectionSideInset = (env.container.contentSize.width - groupWidth)/2
                section.contentInsets = .init(top: 0, leading: sectionSideInset, bottom: 0, trailing: sectionSideInset)
                section.orthogonalScrollingBehavior = .groupPaging
                return section
            case 1:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1)))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets.top = 16
                section.orthogonalScrollingBehavior = .none
                return section
            case 2:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                item.contentInsets = .init(top: 16, leading: 16, bottom: 16, trailing: 16)
                let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(180)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets.top = 16
                return section
            case 3:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(60)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets.leading = 20
                return section
            case 4...5:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(44)), elementKind: "Header", alignment: .topLeading)]
                section.contentInsets = .init(top: 0, leading: 16, bottom: 16, trailing: 16)
                return section
            case 6:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(44)), elementKind: "Header", alignment: .topLeading)]
                section.contentInsets = .init(top: .zero, leading: 16, bottom: 16, trailing: 16)
                return section
            default:
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(0)), subitems: [])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .paging
                return section
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
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as? ImageCollectionViewCell else { return UICollectionViewCell() }
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
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TextCollectionViewCell", for: indexPath) as? TextCollectionViewCell else { return .init() }
            cell.textLabel.text = rocketDetails.description ?? "N/A"
            return cell
        case 2:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RocketSizeCollectionViewCell", for: indexPath) as? RocketSizeCollectionViewCell else { return .init() }
            cell.heightValueLabel.text = "\(rocketDetails.height?.meters ?? 0.0) m"
            cell.massValueLabel.text = "\(rocketDetails.mass?.kg ?? 0.0) kg"
            cell.diameterValueLabel.text = "\(rocketDetails.diameter?.meters ?? 0.0) m"
            return cell
        case 3:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CountryCollectionViewCell", for: indexPath) as? CountryCollectionViewCell else { return .init() }
            cell.countryNameLabel.text = rocketDetails.country ?? "N/A"
            if rocketDetails.country == "United States" {
                cell.countryFlagLabel.text = "🇺🇸"
            } else if rocketDetails.country == "Republic of the Marshall Islands" {
                cell.countryFlagLabel.text = "🇲🇭"
            }
            return cell
        case 4:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RocketStageCollectionViewCell", for: indexPath) as? RocketStageCollectionViewCell else { return .init() }
            cell.enginesValueLabel.text = "\(rocketDetails.firstStage?.engines ?? 0)"
            cell.burnTimeValueLabel.text = "\(rocketDetails.firstStage?.burnTimeSec ?? 0) seconds"
            cell.fuelAmountValueLabel.text = "\(rocketDetails.firstStage?.fuelAmountTons ?? 0.0) tons"
            if let isReusable = rocketDetails.firstStage?.reusable {
                cell.reusableValueLabel.text = isReusable ? "Yes" : "No"
            }
            return cell
        case 5:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RocketStageCollectionViewCell", for: indexPath) as? RocketStageCollectionViewCell else { return .init() }
            cell.enginesValueLabel.text = "\(rocketDetails.secondStage?.engines ?? 0)"
            cell.burnTimeValueLabel.text = "\(rocketDetails.secondStage?.burnTimeSec ?? 0) seconds"
            cell.fuelAmountValueLabel.text = "\(rocketDetails.secondStage?.fuelAmountTons ?? 0.0) tons"
            if let isReusable = rocketDetails.secondStage?.reusable {
                cell.reusableValueLabel.text = isReusable ? "Yes" : "No"
            }
            return cell
        case 6:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RocketLaunchCostCollectionViewCell", for: indexPath) as? RocketLaunchCostCollectionViewCell else { return .init() }
            cell.moneyLabel.text = "$ \((rocketDetails.costPerLaunch ?? 0).formattedWithSeparator)"
            return cell
        default:
            return .init()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderCollectionReusableView", for: indexPath) as? HeaderCollectionReusableView else { return UICollectionReusableView() }
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
