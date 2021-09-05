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
    mutating func checkNowPage(widthPerPage: CGFloat,
                               selectedConstraint: CGFloat) {
        let page = Int(selectedConstraint / widthPerPage)
        for postsPage in PostsPageState.allCases
        where postsPage.page == page {
            self = postsPage
        }
        self = .all
    }
    mutating func changeState() {
        switch self {
        case .all: self = .following
        case .following: self = .all
        }
    }
    func isState(_ state: PostsPageState) -> Bool {
        switch state {
        case .all: return self == .following
        case .following: return self == .all
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
    private var nowPostsPage: PostsPageState = .all
    private let homeContainerPostsIdentifier = "HomeContainerPostsIdentifier"
    
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
        if nowPostsPage.isState(.all) {
            homeContainerPostsVC.scrollToPage(state: .all, animated: true)
            nowPostsPage.changeState()
        }
    }
    
    @IBAction private func followingButtonDidTapped(_ sender: Any) {
        guard let homeContainerPostsVC = children.first as? HomeContainerPostsViewController else { return }
        if nowPostsPage.isState(.following) {
            homeContainerPostsVC.scrollToPage(state: .following, animated: true)
            nowPostsPage.changeState()
        }
    }
    
    private func showLoginOrSignUpVC() {
        let loginOrSignUpVC = LoginOrSignUpViewController.instantiate()
        let nav = UINavigationController(rootViewController: loginOrSignUpVC)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == homeContainerPostsIdentifier {
            let homeContainerPostsVC = segue.destination as? HomeContainerPostsViewController
            homeContainerPostsVC?.delegate = self
        }
    }
    
}

extension HomeViewController: HomeContainerPostsVCDelegate {
    
    func moveSelectedMarkView(contentOffset: CGFloat) {
        selectedMarkViewLeftConstraint.constant = contentOffset
    }
    
    func checkNowPage(widthPerPage: CGFloat) {
        nowPostsPage.checkNowPage(widthPerPage: widthPerPage,
                                  selectedConstraint: selectedMarkViewLeftConstraint.constant)
    }
    
}
