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
}
