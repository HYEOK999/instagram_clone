//
//  ProfileCollectionReusableView.swift
//  instagram_clone01
//
//  Created by HYEOKBOOK on 25/07/2019.
//  Copyright © 2019 HYEOKBOOK. All rights reserved.
//

import UIKit

class ProfileCollectionReusableView: UICollectionReusableView {
        
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var myPostCount: UILabel!
    @IBOutlet weak var myFallowingCount: UILabel!
    @IBOutlet weak var myFollowerCount: UILabel!
 
    var user: UserModel? {
        didSet{
            updateView()
        }
    }
    
    func updateView(){
        self.name.text = user!.username
        if let photoUrlString = user!.profileImgUrl {
            let photoUrl = URL(string: photoUrlString)
//            self.profileImg.sd_setImage(with: photoUrl)
            self.profileImg.kf.setImage(with: photoUrl)
        }
    }
    
}
