//
//  CameraViewController.swift
//  PetSNS
//
//  Created by 大西玲音 on 2021/08/23.
//

import UIKit

final class CameraViewController: UIViewController {

    @IBOutlet private weak var cameraView: UIView!
    @IBOutlet private weak var shutterButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction private func closeButtonDidTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction private func shutterButtonDidTapped(_ sender: Any) {
        let editingPostVC = EditingPostViewController.instantiate()
        self.navigationController?.pushViewController(editingPostVC, animated: true)
    }

    @IBAction private func stillImageShootingButtonDidTapped(_ sender: Any) {
    }

    @IBAction private func movieShootingButtonDidTapped(_ sender: Any) {
    }

}
