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
        
        setupAllTableView()
        setupFollowingTableView()
        setupScrollView()
        
    }
    
    private func setupAllTableView() {
        allTableView.delegate = self
        allTableView.dataSource = self
        allTableView.rowHeight = UITableView.automaticDimension
        allTableView.register(HomePostTableViewCell.nib,
                              forCellReuseIdentifier: HomePostTableViewCell.identifier)
    }
    
    private func setupFollowingTableView() {
        followingTableView.delegate = self
        followingTableView.dataSource = self
        followingTableView.rowHeight = UITableView.automaticDimension
        followingTableView.register(HomePostTableViewCell.nib,
                                    forCellReuseIdentifier: HomePostTableViewCell.identifier)
    }
    
    private func setupScrollView() {
        horizontalScrollView.delegate = self
    }
    
    func scrollToPage(page: Int, animated: Bool) {
        var frame: CGRect = horizontalScrollView.bounds
        frame.origin.x = frame.size.width * CGFloat(page)
        frame.origin.y = 0
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
            let pageCounts = PostsPageState.allCases.count
            let scrollOffset = scrollView.contentOffset.x / CGFloat(pageCounts)
            homeVC.moveSelectedMarkView(contentOffset: scrollOffset)
            print(scrollOffset)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard let homeVC = parent as? HomeViewController else { return }
        if (scrollView == self.horizontalScrollView) {
            print(scrollView.bounds.width)
            let pageCounts = PostsPageState.allCases.count
            let widthPerPage = scrollView.bounds.width / CGFloat(pageCounts)
            homeVC.checkNowPage(widthPerPage: widthPerPage)
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
