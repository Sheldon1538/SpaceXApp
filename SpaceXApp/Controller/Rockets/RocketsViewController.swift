//
//  RocketsViewController.swift
//  SpaceXApp
//
//  Created by Konstantin on 03.02.2021.
//  Copyright © 2021 Konstantin Akchurin. All rights reserved.
//

import UIKit

struct SpaceXRocketsUX {
    static let rowSpacing: CGFloat = 24.0
    static let cellWidthSpacing: CGFloat = 32.0
    static let collectionViewTopSpacing: CGFloat = 16.0
    static let collectionViewLeftSpacing: CGFloat = 0.0
    static let collectionViewBottomSpacing: CGFloat = 8.0
    static let collectionViewRightSpacing: CGFloat = 0.0
}

class RocketsViewController: UIViewController {
    var collectionView: UICollectionView!
    var dataProvider: SpaceXDataProvider!
    
    var rockets: [SpaceXRocket] = [] {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    init(dataProvider: SpaceXDataProvider) {
        self.dataProvider = dataProvider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Rockets"
        view.backgroundColor = .white
        setupCollectionViewFlowLayout()
        addCollectionView()
        collectionView.register(RocketPreviewCollectionViewCell.self, forCellWithReuseIdentifier: RocketPreviewCollectionViewCell.identifier)
        loadRockets()
        removeNavigationBarBorderLine()
    }
    
    func loadRockets() {
        dataProvider.getSpaceXRockets { (result) in
            switch result {
            case .success(let rockets):
                self.rockets = rockets
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func setupCollectionViewFlowLayout() {
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
    }
    
    func removeNavigationBarBorderLine() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func addCollectionView() {
        view.addSubview(collectionView)
        collectionView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor)
    }
    
    func presentRocketDetailsViewController(rocketDetails: SpaceXRocket) {
        let viewController = RocketDetailsViewController(rocketDetails: rocketDetails)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension RocketsViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rockets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RocketPreviewCollectionViewCell.identifier, for: indexPath) as? RocketPreviewCollectionViewCell else { return UICollectionViewCell() }
        cell.rocketNameLabel.text = rockets[indexPath.row].name ?? "no data"
        if rockets[indexPath.row].engines?.number == 1 {
            cell.rocketEnginesLabel.text = "1 engine"
        } else {
            cell.rocketEnginesLabel.text = "\(rockets[indexPath.row].engines?.number ?? 0) engines"
        }
        if let firstLaunchDate = rockets[indexPath.row].firstFlight {
            cell.firstLaunchLabel.text = Date().getDateStringInDisplayFormat(utcString: firstLaunchDate, format: DateFormats.spaceXRocketFirstLaunch)
        }
        cell.rocketDescriptionLabel.text = rockets[indexPath.row].description ?? "no data"
        if let imageURL = rockets[indexPath.row].flickrImages.first.flatMap({$0}) {
            dataProvider.downloadImage(url: imageURL) { (result) in
                switch result {
                case .success(let image):
                    DispatchQueue.main.async {
                        cell.rocketImageView.image = image
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: UIScreen.main.bounds.width - SpaceXRocketsUX.cellWidthSpacing, height: 200.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return SpaceXRocketsUX.rowSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: SpaceXRocketsUX.collectionViewTopSpacing, left: SpaceXRocketsUX.collectionViewLeftSpacing, bottom: SpaceXRocketsUX.collectionViewBottomSpacing, right: SpaceXRocketsUX.collectionViewRightSpacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presentRocketDetailsViewController(rocketDetails: rockets[indexPath.row])
    }
}
