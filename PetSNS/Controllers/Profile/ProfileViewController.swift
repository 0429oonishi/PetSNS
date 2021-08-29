//
//  ProfileViewController.swift
//  PetSNS
//
//  Created by 大西玲音 on 2021/08/23.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var followButton: UIButton!
    @IBOutlet private weak var followerButton: UIButton!
    @IBOutlet private weak var editButton: UIButton!
    @IBOutlet private weak var accompanimentCollectionView: UICollectionView!
    @IBOutlet private weak var introductionTextView: UITextView!
    @IBOutlet private weak var postedImageCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction private func followButtonDidTapped(_ sender: Any) {
        let followOrFollowerListVC = FollowOrFollowerListViewController.instantiate()
        self.navigationController?.pushViewController(followOrFollowerListVC, animated: true)
    }
    
    @IBAction private func followerButtonDidTapped(_ sender: Any) {
        let followOrFollowerListVC = FollowOrFollowerListViewController.instantiate()
        self.navigationController?.pushViewController(followOrFollowerListVC, animated: true)
    }
    
    @IBAction private func editButtonDidTapped(_ sender: Any) {
        let additionalOrEditPetProfileVC = AdditionalOrEditPetProfileViewController.instantiate()
        let nav = UINavigationController(rootViewController: additionalOrEditPetProfileVC)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true, completion: nil)
    }
    
    @IBAction private func settingButtonDidTapped(_ sender: Any) {
        let settingVC = SettingViewController.instantiate()
        let nav = UINavigationController(rootViewController: settingVC)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true, completion: nil)
    }
    
}
