//
//  PeopleViewController.swift
//  instagram_clone01
//
//  Created by HYEOKBOOK on 25/07/2019.
//  Copyright © 2019 HYEOKBOOK. All rights reserved.
//

import UIKit

class PeopleViewController: UIViewController {

    @IBOutlet weak var tableVW: UITableView!
    
    var users: [UserModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableVW.delegate = self
        tableVW.dataSource = self
        
        loadUsers()

        // Do any additional setup after loading the view.
    }
    
    func loadUsers() {
        Api.User.observeUsers { (user) in
            self.isFollowing(userId: user.id!, completed: { (value) in
                user.isFollowing = value
                self.users.append(user)
                self.tableVW.reloadData()
            })
        }
    }
    
    func isFollowing(userId: String, completed:@escaping(Bool) -> Void) {
        Api.Follow.isFollowing(userId: userId, complected: completed)
    }
    
}

extension PeopleViewController : UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableVW.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PeopleTableViewCell
        
//        cell.nameLB.text = "aaaaa"
//        cell.profileImg.image = UIImage(named: "Search")
        let user = users[indexPath.row]
        cell.user = user
        return cell
    }
}
