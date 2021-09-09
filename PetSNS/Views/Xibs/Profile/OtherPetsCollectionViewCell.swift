//
//  OtherPetsCollectionViewCell.swift
//  PetSNS
//
//  Created by 坂本龍哉 on 2021/09/08.
//

import UIKit

final class OtherPetsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var otherPetsImageView: UIImageView!
    
    static var identifier: String { String(describing: self) }
    static var nib: UINib { UINib(nibName: String(describing: self), bundle: nil) }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(image: UIImage) {
        otherPetsImageView.image = image
    }
    
    func setCircleImage(height: CGFloat) {
        otherPetsImageView.layer.cornerRadius = height / 2
    }
    
    func changeHighlight() {
        alpha = isHighlighted ? 0.5 : 1.0
    }
    
}
