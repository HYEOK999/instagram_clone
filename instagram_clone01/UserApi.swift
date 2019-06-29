//
//  UserApi.swift
//  instagram_clone01
//
//  Created by HYEOKBOOK on 29/06/2019.
//  Copyright © 2019 HYEOKBOOK. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

class UserApi{
    var REF_USERS = Database.database().reference().child("users")
    
    func observeUserByUsername(username:String, completion:@escaping(UserModel) -> Void){
        REF_USERS.queryOrdered(byChild: "username_lowercase").queryEqual(toValue: username).observeSingleEvent(of: .childAdded) { (snapshot) in
            if let dict = snapshot.value as? [String: Any]{
                let user = UserModel.transformUser(dict: dict, key: snapshot.key)
                completion(user)
            }
        }
    }
    func observeUser(withId uid:String, completion:@escaping(UserModel) -> Void){
        REF_USERS.child(uid).observeSingleEvent(of: .value) { (snapshot) in
            if let dict = snapshot.value as? [String: Any]{
                let user = UserModel.transformUser(dict: dict, key: snapshot.key)
                completion(user)
            }
        }
    }
    func observeCurrentsUser(completion:@escaping(UserModel) -> Void){
        guard let currentUser = Auth.auth().currentUser else{
            return
        }
        REF_USERS.child(currentUser.uid).observeSingleEvent(of: .value) { (snapshot) in
            if let dict = snapshot.value as? [String: Any]{
                let user = UserModel.transformUser(dict: dict, key: snapshot.key)
                completion(user)
            }
        }
    }
    func observeUsers(completion:@escaping(UserModel) -> Void){
        REF_USERS.observe(.childAdded) { (snapshot) in
            if let dict = snapshot.value as? [String: Any]{
                let user = UserModel.transformUser(dict: dict, key: snapshot.key)
                completion(user)
            }
        }
    }
    
    var CURRENT_USER : User?{
        if let currentUser = Auth.auth().currentUser{
            return currentUser
        }
        
        return nil
    }
    
    var REF_CURRENT_USER : DatabaseReference?{
        guard let currentUser = Auth.auth().currentUser else{
            return nil
        }
        
        return REF_USERS.child(currentUser.uid)
    }

}
