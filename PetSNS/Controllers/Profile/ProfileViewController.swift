//
//  ProfileViewController.swift
//  PetSNS
//
//  Created by 大西玲音 on 2021/08/23.
//

import UIKit

struct PetInfomation: Hashable {
    var name: String
    var imageData: Data?
}

final class ProfileViewController: UIViewController {
    
    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var followButton: UIButton!
    @IBOutlet private weak var followerButton: UIButton!
    @IBOutlet private weak var editButton: UIButton!
    @IBOutlet private weak var accompanimentCollectionView: UICollectionView!
    @IBOutlet private weak var introductionTextView: UITextView!
    @IBOutlet private weak var postedImageCollectionView: UICollectionView!
    
    private var myPets: [PetInfomation] =
        [PetInfomation(name: "アッシュ", imageData: nil),
         PetInfomation(name: "アッシュ", imageData: nil),
         PetInfomation(name: "アッシュ", imageData: nil),
         PetInfomation(name: "アッシュ", imageData: nil),
         PetInfomation(name: "アッシュ", imageData: nil),
         PetInfomation(name: "アッシュ", imageData: nil),
         PetInfomation(name: "アッシュ", imageData: nil),
         PetInfomation(name: "アッシュ", imageData: nil),
         PetInfomation(name: "アッシュ", imageData: nil),
         PetInfomation(name: "アッシュ", imageData: nil)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        
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

extension ProfileViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let isAdditionalButtonDidTapped = (indexPath.row == myPets.count)
        if isAdditionalButtonDidTapped {
            let additionalOrEditPetProfileVC = AdditionalOrEditPetProfileViewController.instantiate()
            let navigationVC = UINavigationController(rootViewController: additionalOrEditPetProfileVC)
            present(navigationVC, animated: true, completion: nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? OtherPetsCollectionViewCell else { return }
        cell.changeHighlight()
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? OtherPetsCollectionViewCell else { return }
        cell.changeHighlight()
    }

}

extension ProfileViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myPets.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: OtherPetsCollectionViewCell.identifier, for: indexPath
        ) as! OtherPetsCollectionViewCell
        let isAdditionalButton = (indexPath.row == myPets.count)
        if isAdditionalButton {
            cell.configureAdditionalButton()
        } else {
            cell.configurePet()
        }
        cell.layer.cornerRadius = cell.bounds.height / 2
        return cell
    }
    
}

extension ProfileViewController {
    
    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalHeight(1.0),
                                               heightDimension: .fractionalHeight(1.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitem: item,
                                                       count: 1)
        group.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    private func setupCollectionView() {
        accompanimentCollectionView.collectionViewLayout = createLayout()
        accompanimentCollectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        accompanimentCollectionView.delegate = self
        accompanimentCollectionView.dataSource = self
        accompanimentCollectionView.register(OtherPetsCollectionViewCell.nib,
                                             forCellWithReuseIdentifier: OtherPetsCollectionViewCell.identifier)
    }

}
