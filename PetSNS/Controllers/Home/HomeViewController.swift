//
//  HomeViewController.swift
//  PetSNS
//
//  Created by 大西玲音 on 2021/08/23.
//

import UIKit

enum PostsPageState: CaseIterable {
    case all
    case following
    
    var page: Int {
        switch self {
        case .all: return 0
        case .following: return 1
        }
    }
}

final class HomeViewController: UIViewController {
    
    @IBOutlet private weak var notificationButton: UIBarButtonItem!
    @IBOutlet private weak var allPostsButton: UIButton!
    @IBOutlet private weak var followingButton: UIButton!
    @IBOutlet private weak var selectedMarkView: UIView!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var selectedMarkViewLeftConstraint: NSLayoutConstraint!
    
    private var isLoggedOut = false
    private var nowPostsPage = PostsPageState.all
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isLoggedOut {
            showLoginOrSignUpVC()
        }
        
    }
    
    @IBAction private func notificationButtonDidTapped(_ sender: Any) {
        let notificationListVC = NotificationListViewController.instantiate()
        self.navigationController?.pushViewController(notificationListVC, animated: true)
    }
    
    @IBAction private func allPostsButtonDidTapped(_ sender: Any) {
        guard let homeContainerPostsVC = children.first as? HomeContainerPostsViewController else { return }
        if !(nowPostsPage == .all) {
            homeContainerPostsVC.scrollToPage(page: PostsPageState.all.page,
                                              animated: true)
            nowPostsPage = .all
        }
    }
    
    @IBAction private func followingButtonDidTapped(_ sender: Any) {
        guard let homeContainerPostsVC = children.first as? HomeContainerPostsViewController else { return }
        if !(nowPostsPage == .following) {
            homeContainerPostsVC.scrollToPage(page: PostsPageState.following.page,
                                              animated: true)
            nowPostsPage = .following
        }
    }
    
    private func showLoginOrSignUpVC() {
        let loginOrSignUpVC = LoginOrSignUpViewController.instantiate()
        let nav = UINavigationController(rootViewController: loginOrSignUpVC)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true, completion: nil)
    }
    
    func moveSelectedMarkView(contentOffset: CGFloat) {
        selectedMarkViewLeftConstraint.constant = contentOffset
    }
    
    func checkNowPage(widthPerPage: CGFloat) {
        let page = Int(selectedMarkViewLeftConstraint.constant / widthPerPage)
        for postsPage in PostsPageState.allCases {
            if postsPage.page == page {
                nowPostsPage = postsPage
                return
            }
        }
    }
    
}
