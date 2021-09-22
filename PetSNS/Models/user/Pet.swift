//
//  Pet.swift
//  PetSNS
//
//  Created by 相良 詠斗 on 2021/09/16.
//

import UIKit

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
