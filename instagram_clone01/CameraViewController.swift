//
//  CameraViewController.swift
//  instagram_clone01
//
//  Created by HYEOKBOOK on 06/07/2019.
//  Copyright © 2019 HYEOKBOOK. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage
import SVProgressHUD

class CameraViewController: UIViewController {

    @IBOutlet weak var photo: UIImageView!
    
    @IBOutlet weak var captionTextView: UITextView!
    @IBOutlet weak var shareBtn: UIButton!
    
    var selectedImage : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleSelectPhoto))
        photo.addGestureRecognizer(tapGesture)
        photo.isUserInteractionEnabled = true
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handlePost()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }//키보드 내림
    
    func handlePost(){
        if selectedImage != nil{
            self.shareBtn.isEnabled = true
            self.shareBtn.backgroundColor = UIColor.orange
        }
        else{
            self.shareBtn.isEnabled = false
            self.shareBtn.backgroundColor = UIColor.lightGray
        }
    }// share버튼 ON/OFF 활성화
    
    @objc func handleSelectPhoto(){
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        present(pickerController, animated: true, completion: nil)
    }

    @IBAction func postingBtn(_ sender: Any) {
        view.endEditing(true)
        
        SVProgressHUD.show()
        
        if let profileImg = self.selectedImage, let imgData = profileImg.jpegData(compressionQuality: 0.1){
            let photoIdString = NSUUID().uuidString
            let storageRef = Storage.storage().reference(forURL: Config.STORAGE_ROOF_REF).child("posts").child(photoIdString)
            
            storageRef.putData(imgData, metadata: nil) { (metaData, error) in
                if error != nil{
                    print(error?.localizedDescription)
                    SVProgressHUD.dismiss()
                    return
                }
                else{
                    storageRef.downloadURL(completion: { (url, error) in
                        self.sendDataToDB(photoURL: "\(url)")
                    SVProgressHUD.dismiss()
                    })
                }
            }
        }
    }
    
    func sendDataToDB(photoURL : String){
        let ref = Database.database().reference()
        let postsReference = ref.child("posts")
        let newPostId = postsReference.childByAutoId().key
        let newPostRef = postsReference.child(newPostId!)
//        newPostRef.setValue([
//            "photoURL" : photoURL,
//            "caption" : captionTextView.text!
//            ])
        newPostRef.setValue([
                "photoURL" : photoURL,
                "caption" : captionTextView.text!
        ]) { (err, ref) in
            if err != nil{
                SVProgressHUD.dismiss()
                return
            }
            else{
                self.clean()
                self.tabBarController?.selectedIndex = 0
                SVProgressHUD.dismiss()
            }
        }
        
    }
    
    
    func clean(){
        self.captionTextView.text = ""
        self.photo.image = UIImage(named: "placeholder-photo")
        self.selectedImage = nil
    }
}

extension CameraViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("didFinishPickingMediaWithInfo")
        
        if let pickingImg = info[.originalImage] as? UIImage {
            selectedImage = pickingImg
            photo.image = pickingImg
        }
        dismiss(animated: true, completion: nil)
    }
}
