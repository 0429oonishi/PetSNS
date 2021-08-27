//
//  EditingPostViewController.swift
//  PetSNS
//
//  Created by 大西玲音 on 2021/08/23.
//

import UIKit

final class EditingPostViewController: UIViewController {
    
    @IBOutlet private weak var cancelButton: UIBarButtonItem!
    @IBOutlet private weak var postButton: UIBarButtonItem!
    @IBOutlet private weak var postedPhotoOrVideoView: UIView!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var commentTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction private func postButtonDidTapped(_ sender: Any) {
    }
    
    @IBAction private func cancelButtonDidTapped(_ sender: Any) {
    }
    
    @IBAction private func backButtonDidTapped(_ sender: Any) {
    }
}
