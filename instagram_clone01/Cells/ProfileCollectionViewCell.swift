//
//  ProfileCollectionViewCell.swift
//  instagram_clone01
//
//  Created by HYEOKBOOK on 25/07/2019.
//  Copyright © 2019 HYEOKBOOK. All rights reserved.
//

import UIKit

class ProfileCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var profileIconImg: UIImageView!
    
    var post: PostModel? {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        if let photoUrlString = post?.photoURL {
            let photoUrl = URL(string: photoUrlString)
//            profileIconImg.sd_setImage(with: photoUrl)
            profileIconImg.kf.setImage(with: photoUrl)
        }
    }
    
}
