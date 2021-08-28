//
//  PetInfoTableViewCell.swift
//  PetSNS
//
//  Created by 大西玲音 on 2021/08/28.
//

import UIKit

final class PetInfoTableViewCell: UITableViewCell {

    @IBOutlet private weak var petImageView: UIImageView!
    @IBOutlet private weak var petNameLabel: UILabel!
    
    static var identifier: String { String(describing: self) }
    static var nib: UINib { UINib(nibName: String(describing: self), bundle: nil) }
    
}
