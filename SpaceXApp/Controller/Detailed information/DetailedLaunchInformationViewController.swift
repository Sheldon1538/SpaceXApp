//
//  DetailedLaunchInformationViewController.swift
//  SpaceXApp
//
//  Created by Konstantin on 16/03/2020.
//  Copyright © 2020 Konstantin Akchurin. All rights reserved.
//

import UIKit

class DetailedLaunchInformationViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var launchData: SpaceXLaunch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureData()
        setupTableView()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: LaunchInfoTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: LaunchInfoTableViewCell.identifier)
    }
    
    func configureData() {
        if let missionName = launchData.missionName {
            title = missionName
        }
    }
}

extension DetailedLaunchInformationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LaunchInfoTableViewCell.identifier, for: indexPath) as? LaunchInfoTableViewCell else { return UITableViewCell() }
        cell.configureWith(data: launchData, row: indexPath.row)
        return cell
    }
}
