//
//  DetailedLaunchInformationViewController.swift
//  SpaceXApp
//
//  Created by Konstantin on 16/03/2020.
//  Copyright © 2020 Konstantin Akchurin. All rights reserved.
//

import UIKit

class DetailedLaunchInformationViewController: UIViewController {
    
    var tableView: UITableView!
    var launch: LaunchViewModel
    
    init(launch: LaunchViewModel) {
        self.launch = launch
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureData()
        setupTableView()
        addTableView()
    }
    
    func addTableView() {
        view.addSubview(tableView)
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
    }
    
    func setupTableView() {
        tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.tableFooterView = UIView()
        tableView.register(LaunchInfoTableViewCell.self, forCellReuseIdentifier: LaunchInfoTableViewCell.identifier)
    }
    
    func configureData() {
        title = launch.missionName
    }
}

extension DetailedLaunchInformationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LaunchInfoTableViewCell.identifier, for: indexPath) as? LaunchInfoTableViewCell else { return UITableViewCell() }
        cell.configureWith(data: launch, row: indexPath.row)
        return cell
    }
}
