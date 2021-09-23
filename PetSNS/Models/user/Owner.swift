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
    var follows: [Follow] = []
    var followers: [Follower] = []
}

struct Pet {
    var id: String
    var imageData: Data
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
    var imageData: Data
    var text: String = ""
    var likedUsers: [String] = []
    var comments: [Comment] = []
}

struct Comment {
    let user: String
    let comment: String
}
