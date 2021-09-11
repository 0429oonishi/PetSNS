//
//  CollectionViewCell.swift
//  PetSNS
//
//  Created by 相良 詠斗 on 2021/09/10.
//

import UIKit

final class ThemeColorCollectionViewCell: UICollectionViewCell {
    
    var sellectedColor: ThemeColor = .defaultColor {
        didSet {
            
        }
    }
    static var identifier: String { String(describing: self) }
    static var nib: UINib { UINib(nibName: String(describing: self), bundle: nil) }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.deSellectedColor()
    }
    
    func configure(themeColor: ThemeColor, cornerRadius: CGFloat) {
        
        self.backgroundColor = themeColor.color
        self.layer.cornerRadius = cornerRadius
    }
    
    func setupSellectedColor() {
        self.layer.borderWidth = 5
        self.layer.borderColor = UIColor.yellow.cgColor
    }
    
    func deSellectedColor() {
        self.layer.borderWidth = 0
    }
}
