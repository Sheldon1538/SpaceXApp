//
//  ViewController.swift
//  SpaceXApp
//
//  Created by Konstantin on 13/03/2020.
//  Copyright © 2020 Konstantin Akchurin. All rights reserved.
//

import UIKit

class LaunchesViewController: UIViewController {
    
    var collectionView: UICollectionView!
    var dataProvider: SpaceXService!
    
    var spaceXLaunches: [SpaceXLaunch] = [] {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    var launchesPaginationOffset = 0
    var loadedAllLaunches = false
    
    init(dataProvider: SpaceXDataProvider) {
        self.dataProvider = dataProvider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Launches"
        view.backgroundColor = .white
        setupCollectionViewFlowLayout()
        addCollectionView()
        collectionView.register(LaunchPreviewCollectionViewCell.self, forCellWithReuseIdentifier: LaunchPreviewCollectionViewCell.identifier)
        loadLaunches()
        removeNavigationBarBorderLine()
    }
    
    func setupCollectionViewFlowLayout() {
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
    }
    
    func addCollectionView() {
        view.addSubview(collectionView)
        collectionView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
    }
    
    func loadLaunches() {
        dataProvider.getSpaceXLaunches(paginationOffset: launchesPaginationOffset) { (result) in
            switch result {
            case .success(let launches):
                if launches.isEmpty {
                    self.loadedAllLaunches = true
                } else {
                    self.launchesPaginationOffset += launches.count
                    self.spaceXLaunches += launches
                }
            case .failure(let error):
                print("Error: " + error.localizedDescription)
            }
        }
    }
    
    func presentDetailedInformationController(with data: SpaceXLaunch) {
        let detailedLaunchInformationViewController = DetailedLaunchInformationViewController(launch: data)
        navigationController?.pushViewController(detailedLaunchInformationViewController, animated: true)
    }
    
    func removeNavigationBarBorderLine() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
}

// MARK:- UICollectionView Stack.
extension LaunchesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return spaceXLaunches.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LaunchPreviewCollectionViewCell.identifier, for: indexPath) as? LaunchPreviewCollectionViewCell else { print("Error while configuring the cell."); return UICollectionViewCell() }
        cell.configureWith(data: spaceXLaunches[indexPath.row])
        if let url = spaceXLaunches[indexPath.row].links?.missionPatchSmall {
            dataProvider.downloadImage(url: url) { (result) in
                switch result {
                case .success(let image):
                    if url == cell.imageUrl {
                        DispatchQueue.main.async {
                            cell.rocketImageView.image = image
                        }
                    }
                case .failure(let error):
                    print("Error: " + error.localizedDescription)
                }
            }
        }
        if indexPath.row == spaceXLaunches.count-1 {
            if loadedAllLaunches == false {
                loadLaunches()
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width-32, height: 200.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 0, bottom: 8, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 24.0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presentDetailedInformationController(with: spaceXLaunches[indexPath.row])
    }
}
