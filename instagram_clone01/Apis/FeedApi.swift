//
//  FeedApi.swift
//  instagram_clone01
//
//  Created by HYEOKBOOK on 25/07/2019.
//  Copyright © 2019 HYEOKBOOK. All rights reserved.
//

import Foundation
import FirebaseDatabase

class FeedApi{
    var REF_FEED = Database.database().reference().child("feed")
    
    func observeFeed(withId id : String, complection:@escaping(PostModel) -> Void) {
        REF_FEED.child(id).observe(.childAdded) { (snapshot) in
            let key = snapshot.key
            Api.Post.obsersvePost(withId: key, complection: { (post) in
                complection(post)
            })
        }
    }
    
    func observeFeedRemove(withId id:String, complection:@escaping(String) -> Void) {
        REF_FEED.child(id).observe(.childRemoved) { (snapshot) in
            let key = snapshot.key
            complection(key)
        }
    }
}
