//
//  MyPostApi.swift
//  instagram_clone01
//
//  Created by HYEOKBOOK on 25/07/2019.
//  Copyright © 2019 HYEOKBOOK. All rights reserved.
//

import Foundation
import FirebaseDatabase

class MyPostApi{
    var REF_MYPOSTS = Database.database().reference().child("myPosts")
    
    func fetchMyPosts(userId: String, completion:@escaping(String) -> Void){
        REF_MYPOSTS.child(userId).observe(.childAdded) { (snapshot) in
            completion(snapshot.key)
        }
    }
    
    func fetchCountMyPosts(userId:String, completion:@escaping(Int) -> Void){
        REF_MYPOSTS.child(userId).observe(.value) { (snapshot) in
            let count = Int(snapshot.childrenCount)
            completion(count)
        }
    }
}
