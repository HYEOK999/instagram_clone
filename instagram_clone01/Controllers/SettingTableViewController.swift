//
//  SettingTableViewController.swift
//  instagram_clone01
//
//  Created by HYEOKBOOK on 01/08/2019.
//  Copyright © 2019 HYEOKBOOK. All rights reserved.
//

import UIKit
import FirebaseAuth

class SettingTableViewController: UITableViewController {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    var selectedImg : UIImage?
    var user : UserModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUser()
    }
    
    @IBAction func changeProfilePhoto(_ sender: Any) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        //사진첩 불러오기
        present(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func logOutBtn(_ sender: Any) {
        let alertAction = UIAlertController(title: "로그아웃", message: "정말로 로그아웃을 하시겠습니까?", preferredStyle: .actionSheet)
        let logOutBtn = UIAlertAction(title: "로그아웃하기", style: .default) { (_) in
            do{
                try Auth.auth().signOut()
                (UIApplication.shared.delegate as! AppDelegate).configualInitialVC()
            }catch(let err) {
                print(err.localizedDescription)
            }
        }
        let cancleOK = UIAlertAction(title: "아니오", style: .cancel, handler: nil)
        
        
        alertAction.addAction(logOutBtn)
        alertAction.addAction(cancleOK)
        
        present(alertAction, animated: true, completion: nil)
    }
    
    func loadUser() {
        Api.User.observeCurrentUser { (user) in
            self.nameTextField.text = user.username
            self.emailTextField.text = user.email
            
            if let profileUrl = URL(string: user.profileImgUrl!){
                self.profileImg.kf.setImage(with: profileUrl)
            }
        }
    }
}

extension SettingTableViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("사진선택됬음.")
        if let image = info[.originalImage] as? UIImage{
            selectedImg = image
            profileImg.image = selectedImg
        }
        dismiss(animated: true, completion: nil)
    }
}



