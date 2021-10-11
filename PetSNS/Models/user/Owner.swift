//
//  Owner.swift
//  PetSNS
//
//  Created by 相良 詠斗 on 2021/09/16.
//

import Foundation

struct Owner {
    let pets: [Pet] = []
    let favoritePosts: [String] = []
    let commentPosts: [String] = []
    let follows: [Follow] = []
    let followers: [Follower] = []
}

struct Pet {
    let id: String
    let followId: String
    let imageData: Data
    let name: String
    let introduction: String = ""
    let posts: [Post] = []
}

struct Follow {
    let id: String
}

struct Follower {
    let id: String
}

struct Post {
    let id: String
    let imageData: Data
    let text: String
    let likedUsers: [String] = []
    let comments: [Comment] = []
}

struct Comment {
    let user: String
}
