//
//  PostModel.swift
//  instagram_clone01
//
//  Created by HYEOKBOOK on 06/07/2019.
//  Copyright © 2019 HYEOKBOOK. All rights reserved.
//

import Foundation
class PostModel{
    var uid : String?
    var photoURL : String?
    var caption : String?
}

extension PostModel {
    static func transformPostPhoto(dict: [String:Any]) -> PostModel{
        let post = PostModel()
        post.caption = dict["caption"] as? String
        post.uid = dict["uid"] as? String
        post.photoURL = dict["photoURL"] as? String
        
        return post
    }
    
    static func transformPostVideo(){
        
    }
}
