//
//  Post.swift
//  PetSNS
//
//  Created by 相良 詠斗 on 2021/09/16.
//

import UIKit

struct Post {
    var id: String
    var image: UIImage
    var text: String = ""
    var likedUsers: [String] = []
    var comments: [Comment] = []
}

struct Comment {
    let user: String
    let comment: String
}
