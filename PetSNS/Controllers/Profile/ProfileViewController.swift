//
//  ProfileViewController.swift
//  PetSNS
//
//  Created by 大西玲音 on 2021/08/23.
//

import UIKit

struct PetInfomation {
    var name: String
    var imageData: Data?
}

extension PetInfomation {
    
    static let myPets: [PetInfomation] = [PetInfomation(name: "アッシュ", imageData: nil),
                                          PetInfomation(name: "アッシュ", imageData: nil),
                                          PetInfomation(name: "アッシュ", imageData: nil),
                                          PetInfomation(name: "アッシュ", imageData: nil),
                                          PetInfomation(name: "アッシュ", imageData: nil),
                                          PetInfomation(name: "アッシュ", imageData: nil),
                                          PetInfomation(name: "アッシュ", imageData: nil),
                                          PetInfomation(name: "アッシュ", imageData: nil),
                                          PetInfomation(name: "アッシュ", imageData: nil),
                                          PetInfomation(name: "アッシュ", imageData: nil)
    ]
    
}

final class ProfileViewController: UIViewController {
    
    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var followButton: UIButton!
    @IBOutlet private weak var followerButton: UIButton!
    @IBOutlet private weak var editButton: UIButton!
    @IBOutlet private weak var accompanimentCollectionView: UICollectionView!
    @IBOutlet private weak var introductionTextView: UITextView!
    @IBOutlet private weak var postedImageCollectionView: UICollectionView!
    
    private var testData = PetInfomation.myPets
    private enum CellType: CaseIterable {
        case pet
        case additional
    }
    private func isAdditional(row: Int) -> Bool {
        return testData.count == row
    }
    private func getCellType(row: Int) -> CellType {
        if isAdditional(row: row) {
            return .additional
        } else {
            return .pet
        }
    }
    
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
        presentAdditionalOrEditPetProfileVC()
    }
    
    @IBAction private func settingButtonDidTapped(_ sender: Any) {
        let settingVC = SettingViewController.instantiate()
        let nav = UINavigationController(rootViewController: settingVC)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true, completion: nil)
    }
    
    private func setupCollectionView() {
        accompanimentCollectionView.collectionViewLayout = createLayout()
        accompanimentCollectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        accompanimentCollectionView.delegate = self
        accompanimentCollectionView.dataSource = self
        accompanimentCollectionView.register(OtherPetsCollectionViewCell.nib,
                                             forCellWithReuseIdentifier: OtherPetsCollectionViewCell.identifier)
        accompanimentCollectionView.isScrollEnabled = false
    }
    
    private func presentAdditionalOrEditPetProfileVC() {
        let additionalOrEditPetProfileVC = AdditionalOrEditPetProfileViewController.instantiate()
        let navigationVC = UINavigationController(rootViewController: additionalOrEditPetProfileVC)
        navigationVC.modalPresentationStyle = .fullScreen
        present(navigationVC, animated: true, completion: nil)
    }
    
}

extension ProfileViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        let cellType = getCellType(row: indexPath.row)
        switch cellType {
        case .additional:
            presentAdditionalOrEditPetProfileVC()
        case .pet:
            // ペットの編集に移動させる
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didHighlightItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? OtherPetsCollectionViewCell else { return }
        cell.changeHighlight()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didUnhighlightItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? OtherPetsCollectionViewCell else { return }
        cell.changeHighlight()
    }
    
}

extension ProfileViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        // 追加ボタン用に+1する
        return testData.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: OtherPetsCollectionViewCell.identifier,
            for: indexPath
        ) as! OtherPetsCollectionViewCell
        let image: UIImage = {
            let isAdditionalButton = (indexPath.row == testData.count)
            if isAdditionalButton {
                return UIImage(systemName: "plus.circle")!
            } else {
                return UIImage(named: "pet.noimage.icon")!
            }
        }()
        cell.configure(image: image)
        cell.setCircleImage(height: cell.frame.height)
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
        group.contentInsets = NSDirectionalEdgeInsets(top: 5,
                                                      leading: 5,
                                                      bottom: 5,
                                                      trailing: 5)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        let layout = UICollectionViewCompositionalLayout(section: section)        
        return layout
    }
    
}
