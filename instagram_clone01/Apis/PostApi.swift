//
//  PostApi.swift
//  instagram_clone01
//
//  Created by HYEOKBOOK on 20/07/2019.
//  Copyright © 2019 HYEOKBOOK. All rights reserved.
//

import Foundation
import FirebaseDatabase

class PostApi{
    var REF_POSTS = Database.database().reference().child("posts")
    
    func observePosts(completion:@escaping(PostModel) -> Void){
        REF_POSTS.observe(.childAdded) { (snapshot) in
            if let dict = snapshot.value as? [String:Any] {
                let newPost = PostModel.transformPostPhoto(dict: dict, key: snapshot.key)
                completion(newPost)
            }
        }
    }
}
