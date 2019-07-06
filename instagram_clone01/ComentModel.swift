//
//  ComentModel.swift
//  instagram_clone01
//
//  Created by HYEOKBOOK on 06/07/2019.
//  Copyright © 2019 HYEOKBOOK. All rights reserved.
//

import Foundation

class ComentModel{
    var comentText : String?
    var uid : String?
}

extension ComentModel {
    static func transformComent(dict: [String:Any]) -> ComentModel{
        let coment = ComentModel()
        coment.comentText = dict["coment"] as? String
        coment.uid = dict["uid"] as? String
        
        return coment
    }
}

