//
//  Owner.swift
//  PetSNS
//
//  Created by 相良 詠斗 on 2021/09/16.
//

import Foundation

struct Owner {
    var pets: [Pet] = []
    var favoritePosts: [String] = []
    var commentPosts: [String] = []
    var allFollow: [Follow]
    var allFollower: [Follower]
}

struct Pet {
    var id: String
    var image: UIImage = #imageLiteral(resourceName: "スクリーンショット 2021-09-16 1.09.47.png")
    var name: String
    var introduction: String = ""
    var posts: [Post] = []
    var followId: String
}

struct Follow {
    var id: String
    var follow: [String] = []
}

struct Follower {
    var id: String
    var follower: [String] = []
}

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
