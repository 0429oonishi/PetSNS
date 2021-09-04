//
//  HomeContainerPostsViewController.swift
//  PetSNS
//
//  Created by 坂本龍哉 on 2021/08/26.
//

import UIKit

final class HomeContainerPostsViewController: UIViewController {
    
    @IBOutlet private weak var allTableView: UITableView!
    @IBOutlet private weak var followingTableView: UITableView!
    @IBOutlet private weak var horizontalScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupScrollView()
        
    }
    
    private func setupTableView() {
        [allTableView, followingTableView]
            .forEach {
                $0?.delegate = self
                $0?.dataSource = self
                $0?.rowHeight = UITableView.automaticDimension
                $0?.register(HomePostTableViewCell.nib,
                             forCellReuseIdentifier: HomePostTableViewCell.identifier) }
    }
    
    private func setupScrollView() {
        horizontalScrollView.delegate = self
    }
    
    func scrollToPage(page: Int, animated: Bool) {
            var frame: CGRect = horizontalScrollView.bounds
            frame.origin.x = frame.size.width * CGFloat(page)
            frame.origin.y = 0;
        horizontalScrollView.scrollRectToVisible(frame,
                                                 animated: animated)
        }
    
}

extension HomeContainerPostsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let homeVC = parent as? HomeViewController else { return }
        if (scrollView == self.horizontalScrollView) {
            let scrollOffset = scrollView.contentOffset.x / 2
            homeVC.moveSelectedMarkView(contentOffset: scrollOffset)
            print(scrollOffset)
        }
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
