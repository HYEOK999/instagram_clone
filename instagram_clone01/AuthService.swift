//
//  AuthService.swift
//  instagram_clone01
//
//  Created by HYEOKBOOK on 29/06/2019.
//  Copyright © 2019 HYEOKBOOK. All rights reserved.
//

import Foundation
import SVProgressHUD
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class AuthService{
    static func signIn(email:String, password:String, onSuccess:@escaping()-> Void, onError:@escaping(_ errorMessage:String?)-> Void){
        SVProgressHUD.show()
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil{
                onError(error?.localizedDescription)
                SVProgressHUD.dismiss()
                return
            }
            else{
                onSuccess()
                SVProgressHUD.dismiss()
            }
        }
    }
    
    static func signUp(profileImg:Data, email:String, username:String, password:String, onSuccess:@escaping()-> Void, onError:@escaping(_ errorMessage:String?)-> Void){
        SVProgressHUD.show()
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if error != nil{
                onError(error?.localizedDescription)
                SVProgressHUD.dismiss()
                return
            }
            
            let uid = result!.user.uid
            let storageRef = Storage.storage().reference(forURL: Config.STORAGE_ROOF_REF).child("profile_image").child(uid)
            
            storageRef.putData(profileImg, metadata: nil, completion: { (metadata, error) in
                if error != nil{
                    return
                }
                let profileImgURL = storageRef.downloadURL(completion: { (url, error) in
                    if error != nil{
                        return
                    }
                    if let profileImageURL = url?.absoluteString{
                        self.setUserInformation(profileImgURL: profileImageURL, uid: uid, username: username, email: email, password: password, onSuccess: {
                            onSuccess()
                            SVProgressHUD.dismiss()
                        })
                    }
                })
            })
        }
    }
    
    static func findPw(email:String, onSuccess:@escaping()-> Void, onError:@escaping(_ errorMessage:String?)-> Void){
        SVProgressHUD.show()
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if error != nil{
                onError(error?.localizedDescription)
                SVProgressHUD.dismiss()
                return
            }
            else{
                onSuccess()
                SVProgressHUD.dismiss()
            }
        }
    }
    
    static func setUserInformation(profileImgURL:String, uid:String, username:String, email:String, password:String, onSuccess:@escaping() -> Void){
        let ref = Database.database().reference()
        let usersRef = ref.child("users")
        let newUserRef = usersRef.child(uid)
        newUserRef.setValue([
            "username" : username,
            "email" : email,
            "profileImg" : profileImgURL,
            "username_lowercase" : username.lowercased()
            ])
        onSuccess()
    }
}
