//
//  SettingViewController.swift
//  PetSNS
//
//  Created by 大西玲音 on 2021/08/23.
//

import UIKit

final class SettingViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var logoutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SwitchingTableViewCell.nib,
                           forCellReuseIdentifier: SwitchingTableViewCell.identifier)
        tableView.register(ItemTableViewCell.nib,
                           forCellReuseIdentifier: ItemTableViewCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
    }
    
    @IBAction private func closeButtonDidTapped(_ sender: Any) {
        
    }
    
    @IBAction private func logoutButtonDidTapped(_ sender: Any) {
        
    }
    
}

extension SettingViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.rowHeight
    }
    
}

extension SettingViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let switchingCell = tableView.dequeueReusableCell(
            withIdentifier: SwitchingTableViewCell.identifier, for: indexPath
        ) as! SwitchingTableViewCell
        
        let itemCell = tableView.dequeueReusableCell(
            withIdentifier: ItemTableViewCell.identifier, for: indexPath
        ) as! ItemTableViewCell
        
        if indexPath.row % 2 == 0 {
            return switchingCell
        } else {
            return itemCell
        }
        
    }
    
}
