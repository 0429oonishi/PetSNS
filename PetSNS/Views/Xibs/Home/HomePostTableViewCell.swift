//
//  HomeTableViewCell.swift
//  PetSNS
//
//  Created by 相良 詠斗 on 2021/08/28.
//

import UIKit

final class HomePostTableViewCell: UITableViewCell {

    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var followButton: UIButton!
    @IBOutlet private weak var postImageOrMovieView: UIView!
    @IBOutlet private weak var favoriteButton: UIButton!
    @IBOutlet private weak var postTextView: UITextView!
    
    static var identifier: String { String(describing: self) }
    static var nib: UINib { UINib(nibName: String(describing: self), bundle: nil) }

    @IBAction private func followButtonDidTapped(_ sender: Any) {
    }

    @IBAction private func favoriteButtonDidTapped(_ sender: Any) {
    }

    @IBAction private func messageButtonDidTapped(_ sender: Any) {
    }

}
