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
        collectionView.register(RocketSizeCollectionViewCell.self, forCellWithReuseIdentifier: "RocketSizeCollectionViewCell")
        collectionView.register(TextCollectionViewCell.self, forCellWithReuseIdentifier: "TextCollectionViewCell")
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "ImageCollectionViewCell")
        collectionView.register(CountryCollectionViewCell.self, forCellWithReuseIdentifier: "CountryCollectionViewCell")
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
                let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets.top = 16
                return section
            case 3:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(60)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets.leading = 16
                return section
            default:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                item.contentInsets = .init(top: 16, leading: 16, bottom: 16, trailing: 16)
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200)), subitems: [item])
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
        default:
            return 0
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
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
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TextCollectionViewCell", for: indexPath) as? TextCollectionViewCell else { return UICollectionViewCell() }
            cell.textLabel.text = rocketDetails.description ?? "N/A"
            return cell
        case 2:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RocketSizeCollectionViewCell", for: indexPath) as? RocketSizeCollectionViewCell else { return UICollectionViewCell() }
            cell.heightValueLabel.text = "\(rocketDetails.height?.meters ?? 0.0) m"
            cell.massValueLabel.text = "\(rocketDetails.mass?.kg ?? 0.0) kg"
            cell.diameterValueLabel.text = "\(rocketDetails.diameter?.meters ?? 0.0) m"
            return cell
        case 3:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CountryCollectionViewCell", for: indexPath) as? CountryCollectionViewCell else { return UICollectionViewCell() }
            cell.countryNameLabel.text = rocketDetails.country ?? "N/A"
            if rocketDetails.country == "United States" {
                cell.countryFlagLabel.text = "🇺🇸"
            } else if rocketDetails.country == "Republic of the Marshall Islands" {
                cell.countryFlagLabel.text = "🇲🇭"
            }
            return cell
        default:
            return .init()
        }
    }
}
