//
//  HomeTableViewCell.swift
//  instagram_clone01
//
//  Created by HYEOKBOOK on 06/07/2019.
//  Copyright © 2019 HYEOKBOOK. All rights reserved.
//

import UIKit
import Kingfisher
import FirebaseDatabase
import FirebaseAuth

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
    var postRef : DatabaseReference!
    
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
//            postImageView.sd_setImage(with: photoUrl)
            postImageView.kf.setImage(with: photoUrl)
            
        }
        Database.database().reference().child("posts").child(self.post!.id!).observeSingleEvent(of: .value) { (snapshot) in
            if let dict = snapshot.value as? [String:Any] {
                let post = PostModel.transformPostPhoto(dict: dict, key: snapshot.key)
                self.updatLike(post: post)
            }
        }
        
        Api.Post.REF_POSTS.child(post!.id!).observe(.childChanged) { (snapshot) in
            if let value = snapshot.value as? Int{
                self.likeCountBtn.setTitle("\(value) likes", for: .normal)
            }
        }
    }
    
    func setUserInfo(){
        nameLabel.text = user?.username
        if let photoUrlString = user?.profileImgUrl{
            let photoUrl = URL(string: photoUrlString)
//            profileImageView.sd_setImage(with: photoUrl, placeholderImage: UIImage(named: "placeholderImg"))
            profileImageView.kf.setImage(with: photoUrl)
        }
    }
    
    func updatLike(post: PostModel){
        let imageName = post.likes == nil || !post.isliked! ? "like" : "likeSelected"
        likeImageView.image = UIImage(named: imageName)
        guard let count = post.likeCount else {
            return
        }
        if count != 0 {
            likeCountBtn.setTitle("\(count) likes", for: .normal)
        }else{
            likeCountBtn.setTitle("No likes", for: .normal)
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
        
        let tapGestureLikeImgView = UITapGestureRecognizer(target: self, action: #selector(self.likeImageView_TouchUpInside))
        likeImageView.addGestureRecognizer(tapGestureLikeImgView)
        likeImageView.isUserInteractionEnabled = true
    }

    @objc func likeImageView_TouchUpInside(){
        postRef = Api.Post.REF_POSTS.child(post!.id!)
        incrementLikes(forRef: postRef)
    }
    
    func incrementLikes(forRef ref: DatabaseReference){
        ref.runTransactionBlock({ (currentData) -> TransactionResult in
            if var post = currentData.value as? [String : AnyObject], let uid = Auth.auth().currentUser?.uid{
                var likes : Dictionary<String, Bool>
                likes = post["likes"] as? [String : Bool] ?? [:]
                var likeCount = post["likeCount"] as? Int ?? 0
                if let _ = likes[uid] {
                    likeCount -= 1 // 취소하면 -1씩 감소
                    likes.removeValue(forKey: uid)
                }else{
                    likeCount += 1
                    likes[uid] = true
                }
                post["likeCount"] = likeCount as AnyObject?
                post["likes"] = likes as AnyObject?

                currentData.value = post
                return TransactionResult.success(withValue: currentData)
            }
            return TransactionResult.success(withValue: currentData)
        }) { (error, comitted, snapshot) in
            if let error = error{
                print(error.localizedDescription)
            }
            else{
                if let dict = snapshot?.value as? [String:Any] {
                    let post = PostModel.transformPostPhoto(dict: dict, key: snapshot!.key)
                    self.updatLike(post: post)
                }
            }
        }
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
