//
//  CollectionViewCell.swift
//  PetSNS
//
//  Created by 相良 詠斗 on 2021/09/10.
//

import UIKit

final class ThemeColorCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var checkmarkImageView: UIImageView!
    static var identifier: String { String(describing: self) }
    static var nib: UINib { UINib(nibName: String(describing: self), bundle: nil) }
    
    func configure(color: UIColor,
                   isHidden: Bool,
                   imageColor: UIColor) {
        self.backgroundColor = color
        checkmarkImageView.isHidden = isHidden
        let image = checkmarkImageView.image?.withTintColor(imageColor)
        checkmarkImageView.image = image
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = self.frame.height / 2
        
    }
    
}
