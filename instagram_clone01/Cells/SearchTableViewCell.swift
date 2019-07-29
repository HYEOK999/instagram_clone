//
//  SearchTableViewCell.swift
//  instagram_clone01
//
//  Created by HYEOKBOOK on 25/07/2019.
//  Copyright © 2019 HYEOKBOOK. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var followBtn: UIButton!
    @IBOutlet weak var nameLB: UILabel!
    
    var user:UserModel? {
        didSet{
            updateView()
        }
    }
    
    func updateView() {
        nameLB.text = user?.username
        if let photoUrlString = user?.profileImgUrl {
            let photoUrl = URL(string: photoUrlString)
            profileImg.sd_setImage(with: photoUrl, placeholderImage: UIImage(named: "placeholderImg"))
        }
        
        Api.Follow.isFollowing(userId: user!.id!) { (value) in
            if value {
                self.configureUnFollowBtn()
            }
            else{
                self.configureFollowBtn()
            }
        }
    }
    
    func configureFollowBtn() {
        followBtn.layer.borderWidth = 1
        followBtn.layer.borderColor = UIColor(red: 226/255, green: 228/255, blue: 232/255, alpha: 1).cgColor
        followBtn.layer.cornerRadius = 5
        followBtn.clipsToBounds = true
        
        followBtn.setTitleColor(UIColor.white, for: .normal)
        followBtn.backgroundColor = UIColor(red: 69/255, green: 142/255, blue: 255/255, alpha: 1)
        followBtn.setTitle("Follow", for: .normal)
        followBtn.addTarget(self, action: #selector(self.followAction), for: .touchUpInside)
    }
    
    func configureUnFollowBtn() {
        followBtn.layer.borderWidth = 1
        followBtn.layer.borderColor = UIColor(red: 226/255, green: 228/255, blue: 232/255, alpha: 1).cgColor
        followBtn.layer.cornerRadius = 5
        followBtn.clipsToBounds = true
        
        followBtn.setTitleColor(UIColor.black, for: .normal)
        followBtn.backgroundColor = UIColor.clear
        followBtn.setTitle("Following", for: .normal)
        followBtn.addTarget(self, action: #selector(self.unFollowAction), for: .touchUpInside)
    }
    
    @objc func followAction(){
        Api.Follow.followAction(withUser: user!.id!)
        configureUnFollowBtn()
        
    }
    
    @objc func unFollowAction(){
        Api.Follow.unFollowAction(withUser: user!.id!)
        configureFollowBtn()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
