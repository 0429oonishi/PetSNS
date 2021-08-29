//
//  ChoosableCameraOrLibraryViewController.swift
//  PetSNS
//
//  Created by 大西玲音 on 2021/08/23.
//

import UIKit

final class ChoosableCameraOrLibraryViewController: UIViewController {
    
    @IBOutlet private weak var startCameraButton: UIButton!
    @IBOutlet private weak var selectLibraryButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction private func startCameraButtonDidTapped(_ sender: Any) {
        let cameraVC = CameraViewController.instantiate()
        let nav = UINavigationController(rootViewController: cameraVC)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true, completion: nil)
    }
    
    @IBAction private func selectLibraryButtonDidTapped(_ sender: Any) {
        // MARK: - ToDo ライブラリを表示する処理を書く
    }
    
}
