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
    @IBOutlet weak var fallowBtn: UIButton!
    
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
        
        Api.MyPosts.fetchCountMyPosts(userId: user!.id!) { (count) in
            self.myPostCount.text = "\(count)"
        }
        
        Api.Follow.fetchCountFollowing(userId: user!.id!) { (count) in
            self.myFallowingCount.text = "\(count)"
        }
        
        Api.Follow.fetchCountFollowers(userId: user!.id!) { (count) in
            self.myFollowerCount.text = "\(count)"
        }
        
        if user?.id == Api.User.CURRENT_USER?.uid{
            fallowBtn.setTitle("Edit Profile", for: .normal)
        }else {
            updateStateFallowBtn()
        }
    }
    
    func updateStateFallowBtn(){
        if user!.isFollowing! {
            configueUnFallowBtn()
        } else {
            configueFallowBtn()
        }
    }
    
    func configueFallowBtn() {
        fallowBtn.layer.borderWidth = 1
        fallowBtn.layer.borderColor = UIColor.green.cgColor
        fallowBtn.layer.cornerRadius = 5.0
        fallowBtn.clipsToBounds = true
        
        fallowBtn.setTitleColor(.green, for: .normal)
        fallowBtn.backgroundColor = .gray
        fallowBtn.setTitle("Fallow", for: .normal)
        fallowBtn.addTarget(self, action: #selector(self.fallowAction), for: .touchUpInside)
        
    }
    
    func configueUnFallowBtn() {
        fallowBtn.layer.borderWidth = 1
        fallowBtn.layer.borderColor = UIColor.purple.cgColor
        fallowBtn.layer.cornerRadius = 5.0
        fallowBtn.clipsToBounds = true
        
        fallowBtn.setTitleColor(.purple, for: .normal)
        fallowBtn.backgroundColor = .lightGray
        fallowBtn.setTitle("Fallow", for: .normal)
        fallowBtn.addTarget(self, action: #selector(self.unFallowAction), for: .touchUpInside)
    }
    
    @objc func fallowAction() {
        
    }
    
    @objc func unFallowAction() {
        
    }
}
