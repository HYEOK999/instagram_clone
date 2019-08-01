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
//
//    func observePosts(completion:@escaping(PostModel) -> Void){
//        REF_POSTS.observe(.childAdded) { (snapshot) in
//            if let dict = snapshot.value as? [String:Any] {
//                let newPost = PostModel.transformPostPhoto(dict: dict, key: snapshot.key)
//                completion(newPost)
//            }
//        }
//    }
//
//    func obsersvePost(withId id: String, complection: @escaping(PostModel) -> Void){
//        REF_POSTS.child(id).observeSingleEvent(of: DataEventType.value) { (snapshot) in
//            if let dict = snapshot.value as? [String:Any]{
//                let post = PostModel.transformPostPhoto(dict: dict, key: snapshot.key)
//                complection(post)
//            }
//        }
//    }
    
    func observePosts(completion: @escaping (PostModel) -> Void) {
        REF_POSTS.observe(.childAdded) { (snapshot: DataSnapshot) in
            if let dict = snapshot.value as? [String: Any] {
                let newPost = PostModel.transformPostPhoto(dict: dict, key: snapshot.key)
                completion(newPost)
            }
        }
    }
    
    func observePost(withId id: String, completion: @escaping (PostModel) -> Void) {
        REF_POSTS.child(id).observeSingleEvent(of: DataEventType.value, with: {
            snapshot in
            if let dict = snapshot.value as? [String: Any] {
                let post = PostModel.transformPostPhoto(dict: dict, key: snapshot.key)
                completion(post)
            }
        })
    }
    
    func observeTopPosts(completion:@escaping(PostModel) -> Void) {
        REF_POSTS.queryOrdered(byChild: "likeCount").observeSingleEvent(of: .value) { (snapshot) in
            let arraySnapshot = (snapshot.children.allObjects as! [DataSnapshot]).reversed()
            arraySnapshot.forEach({ (child) in
                if let dict = child.value as? [String:Any]{
                    let post = PostModel.transformPostPhoto(dict: dict, key: snapshot.key)
                    completion(post)
                }
            })
        }
        
    }
}
