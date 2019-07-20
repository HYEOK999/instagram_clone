//
//  SignInViewController.swift
//  instagram_clone01
//
//  Created by HYEOKBOOK on 29/06/2019.
//  Copyright © 2019 HYEOKBOOK. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var constrainToBottom: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signIn(_ sender: Any) {
        view.endEditing(true)

        if emailTF.text == "" || passwordTF.text == ""{
            print("빈칸이 있습니다.")
        }
        else{
            AuthService.signIn(email: emailTF.text!, password: passwordTF.text!, onSuccess: {
                (UIApplication.shared.delegate as! AppDelegate).configualInitialVC()
            }) { (error) in
                print(error)
            }
        }
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
        UIView.animate(withDuration: 0.3) {
            self.constrainToBottom.constant = keyboardFrame!.height
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        UIView.animate(withDuration: 0.3) {
            self.constrainToBottom.constant = 0
            self.view.layoutIfNeeded()
        }
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
