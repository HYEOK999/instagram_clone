//
//  FindPwViewController.swift
//  instagram_clone01
//
//  Created by HYEOKBOOK on 29/06/2019.
//  Copyright © 2019 HYEOKBOOK. All rights reserved.
//

import UIKit

class FindPwViewController: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func findPw(_ sender: Any) {
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
