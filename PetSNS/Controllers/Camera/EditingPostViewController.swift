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
    @IBOutlet private weak var postedPhotosView: UIView!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var commentTextView: UITextView!
    
    private var photoData: Data!
    func receivePhoto(photoData: Data) {
        self.photoData = photoData
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPostedPhotosView()
        
    }
    
    @IBAction private func postButtonDidTapped(_ sender: Any) {
        NotificationCenter.default.post(name: .showHomeVC, object: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            self.dismiss(animated: true)
        }
    }
    
    @IBAction private func cancelButtonDidTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

// MARK: - setup
extension EditingPostViewController {
    
    private func setupPostedPhotosView() {
        guard let photoImage = UIImage(data: photoData) else { return }
        let photoImageView = UIImageView()
        photoImageView.image = photoImage
        postedPhotosView.addSubview(photoImageView)
        
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        [photoImageView.topAnchor.constraint(equalTo: postedPhotosView.topAnchor),
         photoImageView.bottomAnchor.constraint(equalTo: postedPhotosView.bottomAnchor),
         photoImageView.leadingAnchor.constraint(equalTo: postedPhotosView.leadingAnchor),
         photoImageView.trailingAnchor.constraint(equalTo: postedPhotosView.trailingAnchor)]
            .forEach { $0.isActive = true }
    }
    
}
