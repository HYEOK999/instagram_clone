//
//  HomeViewController.swift
//  instagram_clone01
//
//  Created by HYEOKBOOK on 06/07/2019.
//  Copyright © 2019 HYEOKBOOK. All rights reserved.
//

import UIKit
import SVProgressHUD
import FirebaseAuth
import FirebaseDatabase

class HomeViewController: UIViewController {

    @IBOutlet weak var tableVW: UITableView!
    
    var posts = [PostModel]()
    var users = [UserModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableVW.delegate = self
        tableVW.dataSource = self
        tableVW.estimatedRowHeight = 520
//        tableVW.rowHeight = UITableView.automaticDimension
        //자동정리
        loadPosts()
        
        // Do any additional setup after loading the view.
    }
    
    func loadPosts(){
        SVProgressHUD.show()
//        Api.Feed.observeFeed(withId: Api.User.CURRENT_USER!.uid) { (post) in
//            guard let postId = post.uid else{
//                return
//            }
//
//            self.fetchUser(uid: postId, completed: {
//                self.posts.append(post)
//                self.tableVW.reloadData()
//            })
//
//            Api.Feed.observeFeedRemove(withId: Api.User.CURRENT_USER!.uid, complection: { (key) in
//                self.posts = self.posts.filter{ $0.id != key }
//                self.tableVW.reloadData()
//            })
//        }
        Api.Post.observePosts { (post) in
            self.fetchUser(uid: Auth.auth().currentUser!.uid, completed: {
                self.posts.append(post)
                SVProgressHUD.dismiss()
                self.tableVW.reloadData()
            })
       } // 아래의 내용을 PostApi 에 담아서 분리하여 정리하였음.
//        Database.database().reference().child("posts").observe(.childAdded) { (snapshot) in
//            if let dict = snapshot.value as? [String: Any] {
//                let newPost = PostModel.transformPostPhoto(dict: dict)
//                // 사용자 리스트 불러오기
//
//                print(newPost.uid)
//
//                self.fetchUser(uid: Auth.auth().currentUser!.uid, completed: {
//                    self.posts.append(newPost)
//
//                    OperationQueue.main.addOperation {
//                        self.tableVW.reloadData()
//                    }
//                })
//            }
//        }
    }
    
    func fetchUser(uid:String, completed:@escaping () -> Void) {
        Api.User.observeUser(withId: uid) { (user) in
            self.users.append(user)
            completed()
        }  // 아래의 내용을 UserApi 에 담아서 분리하여 정리하였음.
//        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value) { (snapshot) in
//            if let dict = snapshot.value as? [String: Any] {
//                let user = UserModel.transformUser(dict: dict)
//                self.users.append(user)
//                completed()
//            }
//        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "comentSegue"{
            let comentVC = segue.destination as! ComentViewController
            let postId = sender as! String
            comentVC.postId = postId
        }
    }
}


extension HomeViewController : UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableVW.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeTableViewCell
        let post = posts[indexPath.row]
        let user = users[indexPath.row]
        cell.post = post
        cell.user = user
        cell.homeVC = self
        return cell
    }
    
    
}
