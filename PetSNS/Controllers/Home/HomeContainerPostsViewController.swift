//
//  HomeContainerPostsViewController.swift
//  PetSNS
//
//  Created by 坂本龍哉 on 2021/08/26.
//

import UIKit

final class HomeContainerPostsViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(HomePostTableViewCell.nib,
                           forCellReuseIdentifier: HomePostTableViewCell.identifier)
    }
    
}

extension HomeContainerPostsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

extension HomeContainerPostsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: HomePostTableViewCell.identifier
        ) as! HomePostTableViewCell
        return cell
    }
    
}
