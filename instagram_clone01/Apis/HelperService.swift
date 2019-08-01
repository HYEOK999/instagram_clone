//
//  HelperService.swift
//  instagram_clone01
//
//  Created by HYEOKBOOK on 01/08/2019.
//  Copyright © 2019 HYEOKBOOK. All rights reserved.
//

import Foundation
import FirebaseStorage

class HelperService{
    static func uploadDataToServer(data: Data, caption: String, onSuccess:@escaping() -> Void){
        let photoIdString = NSUUID().uuidString
        let storageRef = Storage.storage().reference(forURL: Config.STORAGE_ROOF_REF).child("posts").child(photoIdString)
        
        storageRef.putData(data, metadata: nil) { (metaData, error) in
            if error != nil {
                return
            }
            else{
                storageRef.downloadURL(completion: { (url, error) in
                    
                    let photoUrl = url?.absoluteString
//                    self.sendDataToDB(photoURL: photoUrl!)
                    self.sendDataToDatabase(photoUrl: photoUrl!, caption: caption, onSuccess: {
                        onSuccess()
                    })
                    
                })
            }
        }//end
    }
    
    static func sendDataToDatabase(photoUrl:String, caption:String, onSuccess:@escaping() -> Void) {
        let newPostId = Api.Post.REF_POSTS.childByAutoId().key
        let newPostReference = Api.Post.REF_POSTS.child(newPostId!)
        
        guard let currentUser = Api.User.CURRENT_USER else {
            return
        }
        
        let currentUserId = currentUser.uid
        newPostReference.setValue([
            "photoURL" : photoUrl,
            "caption" : caption,
            "uid" : currentUserId,
            "likeCount" : 0]) { (error, ref) in
                if error != nil {
                    return
                }
                else{
                    Api.Feed.REF_FEED.child(Api.User.CURRENT_USER!.uid).child(newPostId!).setValue(true)
                    
                    let myPostRef = Api.MyPosts.REF_MYPOSTS.child(currentUserId).child(newPostId!)
                    myPostRef.setValue(true, withCompletionBlock: { (error, ref) in
                        if error != nil {
                            return
                        }
                        else {
                            onSuccess()
                        }
                    })
                }
        }
    }
}
