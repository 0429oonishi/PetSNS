//
//  ItemTableViewCell.swift
//  PetSNS
//
//  Created by 坂本龍哉 on 2021/08/29.
//

import UIKit

final class ItemTableViewCell: UITableViewCell {

    @IBOutlet private weak var itemLabel: UILabel!
    
    static var identifier: String { String(describing: self) }
    static var nib: UINib { UINib(nibName: String(describing: self), bundle: nil) }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(title: String) {
        itemLabel.text = title
    }
    
}
