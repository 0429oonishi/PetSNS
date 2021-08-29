//
//  TopTabBarController.swift
//  PetSNS
//
//  Created by 大西玲音 on 2021/08/29.
//

import UIKit

final class TopTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setObserver()
        
    }
    
    private func setObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showHomeVC),
                                               name: .showHomeVC,
                                               object: nil)
    }
    
    @objc
    private func showHomeVC() {
        if let tabBarController = UIApplication.shared.windows.first(
            where: { $0.isKeyWindow }
        )?.rootViewController as? UITabBarController {
            DispatchQueue.main.async {
                tabBarController.selectedIndex = 0
            }
        }
    }
    
}



