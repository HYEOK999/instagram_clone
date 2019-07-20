//
//  PostModel.swift
//  instagram_clone01
//
//  Created by HYEOKBOOK on 06/07/2019.
//  Copyright © 2019 HYEOKBOOK. All rights reserved.
//

import Foundation
import FirebaseAuth
class PostModel{
    var uid : String?
    var photoURL : String?
    var caption : String?
    var id : String?
    var likeCount : Int?
    var likes : Dictionary<String, Any>?
    var isliked: Bool?
}

extension PostModel {
    static func transformPostPhoto(dict: [String:Any], key:String) -> PostModel{
        let post = PostModel()
        post.caption = dict["caption"] as? String
        post.uid = dict["uid"] as? String
        post.photoURL = dict["photoURL"] as? String
        post.id = key
        post.likeCount = dict["likeCount"] as? Int
        post.likes = dict["likes"] as? Dictionary<String, Any>
        if let currentUserId = Auth.auth().currentUser?.uid{
            if post.likes != nil{
                post.isliked = post.likes![currentUserId] != nil
            }
        }
        
        return post
    }
    
    static func transformPostVideo(){
        
    }
}
