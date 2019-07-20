//
//  HomeTableViewCell.swift
//  instagram_clone01
//
//  Created by HYEOKBOOK on 06/07/2019.
//  Copyright © 2019 HYEOKBOOK. All rights reserved.
//

import UIKit
import SDWebImage
import FirebaseDatabase

class HomeTableViewCell: UITableViewCell {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likeImageView: UIImageView!
    @IBOutlet weak var comentImageView: UIImageView!
    @IBOutlet weak var shareImageView: UIImageView!
    @IBOutlet weak var likeCountBtn: UIButton!
    @IBOutlet weak var captionLabel: UILabel!
    
    
    var homeVC : HomeViewController?
    
    var post : PostModel? {
        didSet {
            updateView()
        }
    }
    
    var user : UserModel? {
        didSet {
            setUserInfo()
        }
    }
    
    func updateView(){
        captionLabel.text = post?.caption
        if let photoUrlString = post?.photoURL{
            let photoUrl = URL(string: photoUrlString)
            postImageView.sd_setImage(with: photoUrl)
            
        }
        setUserInfo()
    }
    
    func setUserInfo(){
        nameLabel.text = user?.username
        if let photoUrlString = user?.profileImgUrl{
            let photoUrl = URL(string: photoUrlString)
            profileImageView.sd_setImage(with: photoUrl, placeholderImage: UIImage(named: "placeholderImg"))
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nameLabel.text = ""
        captionLabel.text = ""
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(commentImageView_TouchUpInside))
        comentImageView.addGestureRecognizer(tapGesture)
        comentImageView.isUserInteractionEnabled = true
        // Initialization code
    }

    @objc func commentImageView_TouchUpInside(){
        if let id = post?.id{
            homeVC?.performSegue(withIdentifier: "comentSegue", sender: id)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = UIImage(named: "placeholderImg")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
