//
//  ComentApi.swift
//  instagram_clone01
//
//  Created by HYEOKBOOK on 20/07/2019.
//  Copyright © 2019 HYEOKBOOK. All rights reserved.
//

import Foundation
import FirebaseDatabase

class ComentApi{
    var REF_COMENTS = Database.database().reference().child("comments")
    
    func observeComments(withPostId id:String, completion: @escaping (ComentModel) -> Void){
        REF_COMENTS.child(id).observeSingleEvent(of: .value) { (snapshot) in
            if let dict = snapshot.value as? [String:Any] {
                let newComent = ComentModel.transformComent(dict: dict)
                completion(newComent)
            }
        }
    }
}

