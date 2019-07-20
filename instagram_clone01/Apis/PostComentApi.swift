//
//  PostComentApi.swift
//  instagram_clone01
//
//  Created by HYEOKBOOK on 20/07/2019.
//  Copyright © 2019 HYEOKBOOK. All rights reserved.
//

import Foundation
import FirebaseDatabase

class PostComentApi{
    var REF_POST_COMMENTS = Database.database().reference().child("post-comments")
}
