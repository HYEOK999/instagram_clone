//
//  HomeViewController.swift
//  instagram_clone01
//
//  Created by HYEOKBOOK on 06/07/2019.
//  Copyright © 2019 HYEOKBOOK. All rights reserved.
//

import UIKit
import SVProgressHUD

class HomeViewController: UIViewController {

    @IBOutlet weak var tableVW: UITableView!
    
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
        
    }
    
    func fetchUser(uid:String, completed:@escaping()->Void){
        
        
    }
    
}


extension HomeViewController : UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableVW.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeTableViewCell
        
        return cell
    }
    
    
}
