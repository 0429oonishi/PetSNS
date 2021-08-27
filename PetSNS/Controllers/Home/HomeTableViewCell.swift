//
//  HomeTableViewCell.swift
//  PetSNS
//
//  Created by 相良 詠斗 on 2021/08/28.
//

import UIKit

final class HomeTableViewCell: UITableViewCell {

    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var followButton: UIButton!
    @IBOutlet private weak var postImageView: UIImageView!
    @IBOutlet private weak var favoriteButton: UIButton!
    @IBOutlet private weak var postTextView: UITextView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction private func followButtonDidTapped(_ sender: Any) {
    }

    @IBAction private func favoriteButtonDidTapped(_ sender: Any) {
    }

    @IBAction private func messageButtonDidTapped(_ sender: Any) {
    }

}
