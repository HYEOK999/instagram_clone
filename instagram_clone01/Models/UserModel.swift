//
//  UserModel.swift
//  instagram_clone01
//
//  Created by HYEOKBOOK on 29/06/2019.
//  Copyright © 2019 HYEOKBOOK. All rights reserved.
//

import Foundation
//class UserModel {
//    var email : String?
//    var profileImgUrl : String?
//    var username : String?
//    var id : String?
//    var isFollowing : Bool?
//}
//
//extension UserModel {
//    static func transformUser(dict: [String:Any], key: String) -> UserModel{
//        let user = UserModel()
//        user.email = dict["email"] as? String
//        user.profileImgUrl = dict["profileImgUrl"] as? String
//        user.username = dict["username"] as? String
//        user.id = key
//        return user
//    }
//}



class UserModel {
    var email: String?
    var profileImgUrl: String?
    var username: String?
    var id: String?
    var isFollowing: Bool?
}

extension UserModel {
    static func transformUser(dict: [String: Any], key: String) -> UserModel {
        let user = UserModel()
        user.email = dict["email"] as? String
        user.profileImgUrl = dict["profileImgUrl"] as? String
        user.username = dict["username"] as? String
        user.id = key
        return user
    }
}
