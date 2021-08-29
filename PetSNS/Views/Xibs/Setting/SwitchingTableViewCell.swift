//
//  SwitchingTableViewCell.swift
//  PetSNS
//
//  Created by 坂本龍哉 on 2021/08/28.
//

import UIKit

final class SwitchingTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var itemLabel: UILabel!
    @IBOutlet private weak var settingSwitch: UISwitch!
    
    static var identifier: String { String(describing: self) }
    static var nib: UINib { UINib(nibName: String(describing: self), bundle: nil) }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(title: String, isOn: Bool) {
        itemLabel.text = title
        settingSwitch.isOn = isOn
    }

}
