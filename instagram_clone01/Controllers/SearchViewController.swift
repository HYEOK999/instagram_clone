//
//  SearchViewController.swift
//  instagram_clone01
//
//  Created by HYEOKBOOK on 25/07/2019.
//  Copyright © 2019 HYEOKBOOK. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var tableVW: UITableView!
    
    var searchBar = UISearchBar()
    var users : [UserModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Search"
        searchBar.frame.size.width = view.frame.size.width - 60
        
        let searchItem = UIBarButtonItem(customView: searchBar)
        self.navigationItem.rightBarButtonItem = searchItem
        
        tableVW.dataSource = self
        tableVW.delegate = self
        loadUsers()

        // Do any additional setup after loading the view.
    }
    
    func loadUsers() {
        Api.User.observeUsers { (user) in
            self.isFollowing(userId: user.id!, complected: { (value) in
                user.isFollowing = value
                self.users.append(user)
                self.tableVW.reloadData()
            })
        }
    }
    
    func doSearch(){
        
    }

    func isFollowing(userId: String, complected:@escaping(Bool) ->Void){
        Api.Follow.isFollowing(userId: userId, complected: complected)
    }
}

extension SearchViewController : UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        doSearch()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        doSearch()
    }
    
}

extension SearchViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableVW.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SearchTableViewCell
//        cell.nameLB.text = "aaaaa"
        let user = users[indexPath.row]
        cell.user = user
        return cell
    }
}
