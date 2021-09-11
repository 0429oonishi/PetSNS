//
//  ThemeColorViewController.swift
//  PetSNS
//
//  Created by 大西玲音 on 2021/08/23.
//

import UIKit

final class ThemeColorViewController: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    var selectedCell: ThemeColorCollectionViewCell?
    var selectedColor: ThemeColor = .defaultColor
    private let horizontalSpace : CGFloat = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
    }
}

extension ThemeColorViewController {
    
    
    private func setupCollectionView() {
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ThemeColorCollectionViewCell.nib, forCellWithReuseIdentifier:ThemeColorCollectionViewCell.identifier)
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        collectionView.collectionViewLayout = layout
    }
}

extension ThemeColorViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellSize : CGFloat = self.view.bounds.width / 3 - horizontalSpace
        return CGSize(width: cellSize, height: cellSize)
    }
}

extension ThemeColorViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        
        guard let selectedCell = selectedCell else { return }
        selectedCell.deSellectedColor()
        let new = collectionView.cellForItem(at: indexPath) as! ThemeColorCollectionViewCell
        self.selectedCell = new
        self.selectedColor = ThemeColor.allCases[indexPath.row]
        new.setupSellectedColor()
    }
}

extension ThemeColorViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        ThemeColor.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThemeColorCollectionViewCell.identifier, 
                                                      for: indexPath) as! ThemeColorCollectionViewCell
        cell.configure(themeColor: ThemeColor.allCases[indexPath.row], 
                       cornerRadius: (self.view.bounds.width / 3 - horizontalSpace) / 2)
        
        
        if ThemeColor.allCases[indexPath.row] == selectedColor{
            cell.setupSellectedColor()
            selectedCell = cell
        }
        return cell
    }
}
