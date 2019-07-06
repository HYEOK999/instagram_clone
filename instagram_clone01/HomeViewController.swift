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
        tableVW.rowHeight = UITableView.automaticDimension //자동정리
        loadPosts()
        
        // Do any additional setup after loading the view.
    }
    
    func loadPosts(){
        Database.database().reference().child("posts").observe(.childAdded) { (snapshot) in
            if let dict = snapshot.value as? [String: Any] {
                let newPost = PostModel.transformPostPhoto(dict: dict)
                
                // 사용자 리스트 불러오기
                self.fetchUser(uid: newPost.uid! , completed: {
                    self.posts.append(newPost)
                    
                    OperationQueue.main.addOperation {
                        self.tableVW.reloadData()
                    }
                    
                })
            }
        }
    }
    
    func fetchUser(uid:String, completed:@escaping () -> Void) {
        
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: DataEventType.value) { (snapshot) in
            if let dict = snapshot.value as? [String: Any] {
                let user = UserModel.transformUser(dict: dict)
                self.users.append(user)
                completed()
            }
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
        return cell
    }
    
    
}
