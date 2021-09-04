//
//  HomeViewController.swift
//  PetSNS
//
//  Created by 大西玲音 on 2021/08/23.
//

import UIKit

final class HomeViewController: UIViewController {
    
    @IBOutlet private weak var notificationButton: UIBarButtonItem!
    @IBOutlet private weak var allPostsButton: UIButton!
    @IBOutlet private weak var followingButton: UIButton!
    @IBOutlet private weak var selectedMarkView: UIView!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var selectedMarkViewLeftConstraint: NSLayoutConstraint!
    
    private var isLoggedOut = false
    private var isAllPosts: Bool {
        return selectedMarkViewLeftConstraint.constant == 0
    }
    
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
        if isAllPosts == false {
            homeContainerPostsVC.scrollToPage(page: 0, animated: true)
        }
    }
    
    @IBAction private func followingButtonDidTapped(_ sender: Any) {
        guard let homeContainerPostsVC = children.first as? HomeContainerPostsViewController else { return }
        if isAllPosts {
            homeContainerPostsVC.scrollToPage(page: 1, animated: true)
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
    
}
