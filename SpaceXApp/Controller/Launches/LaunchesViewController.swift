//
//  ViewController.swift
//  SpaceXApp
//
//  Created by Konstantin on 13/03/2020.
//  Copyright © 2020 Konstantin Akchurin. All rights reserved.
//

import UIKit

class LaunchesViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var spaceXLaunches: [SpaceXLaunch] = [] {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    var launchesPaginationOffset = 0
    var loadedAllLaunches = false
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Launches"
        setupCollectionView()
        loadLaunches()
    }
    
    func setupCollectionView() {
        collectionView.delegate             = self
        collectionView.dataSource           = self
        collectionView.alwaysBounceVertical = true
        collectionView.register(LaunchPreviewCollectionViewCell.self, forCellWithReuseIdentifier: LaunchPreviewCollectionViewCell.identifier)
    }
    
    func loadLaunches() {
        let url = SpaceXGetLaunchesURL(offset: launchesPaginationOffset).getURL()
        SpaceXAPIManager.shared.fetch(url: url, type: [SpaceXLaunch].self) { (result) in
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
        let storyBoard = UIStoryboard(name: "DetailedLaunchInformation", bundle: nil)
        guard let detailedInfoVC = storyBoard.instantiateViewController(withIdentifier: "DetailedLaunchInformationViewController") as? DetailedLaunchInformationViewController else { return }
        detailedInfoVC.launchData = data
        navigationController?.pushViewController(detailedInfoVC, animated: true)
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
