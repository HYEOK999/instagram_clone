//
//  ProfileViewController.swift
//  instagram_clone01
//
//  Created by HYEOKBOOK on 29/06/2019.
//  Copyright © 2019 HYEOKBOOK. All rights reserved.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {


    @IBOutlet weak var collectionVW: UICollectionView!
    
    var user : UserModel!
    var posts : [PostModel] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionVW.delegate = self
        collectionVW.dataSource = self
        fetchUser()
        fetchMyPosts()
        // Do any additional setup after loading the view.
    }
    
    func fetchUser() {
        Api.User.observeCurrentUser { (user) in
            self.user = user
            self.navigationItem.title = user.username
            self.collectionVW.reloadData()
        }
    }

    func fetchMyPosts() {
        guard let currentUser = Api.User.CURRENT_USER else{
            return
        }
        
        Api.MyPosts.REF_MYPOSTS.child(currentUser.uid).observe(.childAdded) { (snapshot) in
            Api.Post.obsersvePost(withId: snapshot.key, complection: { (post) in
                self.posts.append(post)
                self.collectionVW.reloadData()
            })
        }
    }
    

    @IBAction func logOutBtn(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            (UIApplication.shared.delegate as! AppDelegate).configualInitialVC()
        }catch(let err) {
            print(err.localizedDescription)
        }
    }
    
    
}

extension ProfileViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionVW.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ProfileCollectionViewCell
      
        let post = posts[indexPath.row]
        cell.post = post
        
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerViewCell = collectionVW.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerProfile", for: indexPath) as! ProfileCollectionReusableView
      
        
        if let user = self.user{
            headerViewCell.user = user
        }
        
        return headerViewCell
    }
}


extension ProfileViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionVW.frame.size.width / 3 - 1, height: collectionVW.frame.size.height / 3 - 1)
    }
}
