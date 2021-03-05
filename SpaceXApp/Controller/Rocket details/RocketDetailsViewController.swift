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
    var collectionView: UICollectionView!
    
    init(rocketDetails: SpaceXRocket) {
        self.rocketDetails = rocketDetails
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        title = rocketDetails.name ?? "Rocket name"
        view.backgroundColor = .white
    }
    
    func setupCollectionViewFlowLayout() {
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
    }
}

extension RocketDetailsViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    
}
