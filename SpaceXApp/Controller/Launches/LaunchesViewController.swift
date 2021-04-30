//
//  ViewController.swift
//  SpaceXApp
//
//  Created by Konstantin on 13/03/2020.
//  Copyright © 2020 Konstantin Akchurin. All rights reserved.
//

import UIKit

struct SpaceXLaunchesUX {
    static let rowSpacing: CGFloat = 24.0
    static let cellWidthSpacing: CGFloat = 32.0
    static let collectionViewTopSpacing: CGFloat = 16.0
    static let collectionViewLeftSpacing: CGFloat = 0.0
    static let collectionViewBottomSpacing: CGFloat = 8.0
    static let collectionViewRightSpacing: CGFloat = 0.0
}

class LaunchesViewController: UIViewController {
    var collectionView: UICollectionView!
    var viewModel: LaunchesViewModelProtocol
    
    var spaceXLaunches: [LaunchViewModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    var launchesPaginationOffset = 0
    var loadedAllLaunches = false
    
    init(viewModel: LaunchesViewModelProtocol) {
        self.viewModel = viewModel
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
        view.backgroundColor = UIColor(named: "background")
        setupViewModel()
        viewModel.didScrollAllLaunches()
        setupCollectionViewFlowLayout()
        addCollectionView()
        collectionView.register(LaunchPreviewCollectionViewCell.self, forCellWithReuseIdentifier: LaunchPreviewCollectionViewCell.identifier)
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
    
    private func setupViewModel() {
        viewModel.didUpdateLaunches = { [weak self] launches in
            guard let strongSelf = self else { return }
            strongSelf.spaceXLaunches = launches
        }
    }
    
    func presentDetailedInformationController(with data: LaunchViewModel) {
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
        cell.tag = indexPath.row
        viewModel.loadImageData(url: spaceXLaunches[indexPath.row].imageURL) { (data) in
            DispatchQueue.main.async {
                if indexPath.row == cell.tag {
                    if let image = UIImage(data: data) { cell.rocketImageView.image = image }
                }
            }
        }
        if indexPath.row == spaceXLaunches.count-1 {
            viewModel.didScrollAllLaunches()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - SpaceXLaunchesUX.cellWidthSpacing, height: 200.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: SpaceXLaunchesUX.collectionViewTopSpacing, left: SpaceXLaunchesUX.collectionViewLeftSpacing, bottom: SpaceXLaunchesUX.collectionViewBottomSpacing, right: SpaceXLaunchesUX.collectionViewRightSpacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return SpaceXLaunchesUX.rowSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presentDetailedInformationController(with: spaceXLaunches[indexPath.row])
    }
}
