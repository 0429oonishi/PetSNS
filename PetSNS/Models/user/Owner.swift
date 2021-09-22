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
