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
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction private func notificationButtonDidTapped(_ sender: Any) {
    }
    
    @IBAction private func allPostsButtonDidTapped(_ sender: Any) {
    }
    
    @IBAction private func followingButtonDidTapped(_ sender: Any) {
    }
}
