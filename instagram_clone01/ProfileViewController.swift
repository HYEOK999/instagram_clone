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


    var user : UserModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func fetchUser() {
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func logOutBtn(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            (UIApplication.shared.delegate as! AppDelegate).configualInitialVC()
        }catch(let err) {
            print(err.localizedDescription)
        }
    }
    
    
}
