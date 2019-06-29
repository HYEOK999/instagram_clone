//
//  SignUpViewController.swift
//  instagram_clone01
//
//  Created by HYEOKBOOK on 29/06/2019.
//  Copyright © 2019 HYEOKBOOK. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    var selectedImg : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleSelectedProfileImgView))
        profileImg.addGestureRecognizer(tapGesture)
        profileImg.isUserInteractionEnabled = true
        
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc func handleSelectedProfileImgView(){
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        present(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func signUp(_ sender: Any) {
        
        view.endEditing(true)
        
        if emailTF.text == "" || usernameTF.text == "" || passwordTF.text == "" {
            print("빈칸이 있습니다.")
        }
        else{
            if let profileImg = self.selectedImg, let imageData = profileImg.jpegData(compressionQuality: 0.1) {
                AuthService.signUp(profileImg: imageData, email: emailTF.text!, username: usernameTF.text!, password: passwordTF.text!, onSuccess: {
                    (UIApplication.shared.delegate as! AppDelegate).configualInitialVC()
                }) { (error) in
                    print(error)
                }
            }
        }
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

extension SignUpViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage{
            selectedImg = image
            profileImg.image = selectedImg
        }
        dismiss(animated: true, completion: nil)
    }
}
