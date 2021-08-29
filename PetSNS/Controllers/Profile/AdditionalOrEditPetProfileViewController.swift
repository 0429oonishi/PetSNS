//
//  AdditionalPetViewController.swift
//  PetSNS
//
//  Created by 大西玲音 on 2021/08/23.
//

import UIKit

final class AdditionalOrEditPetProfileViewController: UIViewController {

    @IBOutlet private weak var profilePhotoImageView: UIImageView!
    @IBOutlet private weak var changeProfilePhotoButton: UIButton!
    @IBOutlet private weak var otherPetCollectionView: UICollectionView!
    @IBOutlet private weak var petNameTextField: UITextField!
    @IBOutlet private weak var petIntroductionTextView: UITextView!
    @IBOutlet private weak var saveButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction private func closeButtonDidTapped(_ sender: Any) {
    }

    @IBAction private func saveButtonDidTapped(_ sender: Any) {
    }

}
