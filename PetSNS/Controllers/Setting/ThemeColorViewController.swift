//
//  ThemeColorViewController.swift
//  PetSNS
//
//  Created by 大西玲音 on 2021/08/23.
//

import UIKit

final class ThemeColorViewController: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private var selectedThemeColor: ThemeColor = .white
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        
    }
    
}

extension ThemeColorViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        selectedThemeColor = ThemeColor.allCases[indexPath.item]
        collectionView.reloadData()
    }
    
}

extension ThemeColorViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        ThemeColor.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ThemeColorCollectionViewCell.identifier,
            for: indexPath
        ) as! ThemeColorCollectionViewCell
        let themeColor = ThemeColor.allCases[indexPath.item]
        let isHidden = themeColor != selectedThemeColor
        let imageColor: UIColor = {
            if selectedThemeColor == .black {
                return .white
            }
            return .black
        }()
        cell.configure(color: themeColor.color,
                       isHidden: isHidden,
                       imageColor: imageColor)
        return cell
    }
    
}

extension ThemeColorViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let horizontalSpace: CGFloat = 20
        let cellSize : CGFloat = collectionView.bounds.width / 3 - horizontalSpace
        return CGSize(width: cellSize, height: cellSize)
    }
    
}

extension ThemeColorViewController {
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ThemeColorCollectionViewCell.nib,
                                forCellWithReuseIdentifier: ThemeColorCollectionViewCell.identifier)
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        collectionView.collectionViewLayout = layout
    }
    
}
