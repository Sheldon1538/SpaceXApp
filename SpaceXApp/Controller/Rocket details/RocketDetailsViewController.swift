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
}
