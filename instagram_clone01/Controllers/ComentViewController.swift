//
//  ComentViewController.swift
//  instagram_clone01
//
//  Created by HYEOKBOOK on 06/07/2019.
//  Copyright © 2019 HYEOKBOOK. All rights reserved.
//

import UIKit
import FirebaseAuth
import SVProgressHUD
import FirebaseDatabase

class ComentViewController: UIViewController {

    @IBOutlet weak var tableVW: UITableView!
    @IBOutlet weak var comentTextField: UITextField!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var constraintToBottom: NSLayoutConstraint!
    
    var postId : String!
    var users = [UserModel]()
    var comments = [ComentModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableVW.delegate = self
        tableVW.dataSource = self
        loadComents()
        empty()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        // Do any additional setup after loading the view.
    }
    
    func loadComents(){
        Api.PostComent.REF_POST_COMMENTS.child(self.postId).observe(.childAdded) { (snapshot) in
            Api.Coment.observeComments(withPostId: snapshot.key, completion: { (comment) in
                self.fetchUser(uid: comment.uid!, completed: {
                    self.comments.append(comment)
                    self.tableVW.reloadData()
                })
            })
        }
    }
    
    func fetchUser(uid:String, completed:@escaping() -> Void){
        Api.User.observeUser(withId: uid) { (user) in
            self.users.append(user)
            completed()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
        UIView.animate(withDuration: 0.3) {
            self.constraintToBottom.constant = keyboardFrame!.height
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        UIView.animate(withDuration: 0.3) {
            self.constraintToBottom.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func sendBtn(_ sender: Any) {
        let commentsReference = Api.Coment.REF_COMENTS
        let newCommentId = commentsReference.childByAutoId().key
        let newCommentReference = commentsReference.child(newCommentId!)
        guard let currentsUser = Auth.auth().currentUser else{
            return
        }
        let currentsUserId = currentsUser.uid
        
        newCommentReference.setValue([
            "uid" : currentsUserId,
            "commentText" : comentTextField.text!
        ]) { (err, ref) in
            if err != nil{
                return
            }
            else{
                let postCommentRef = Api.PostComent.REF_POST_COMMENTS.child(self.postId).child(newCommentId!)
                postCommentRef.setValue(true, withCompletionBlock: { (err, ref) in
                    if err != nil{
                        return
                    }
                    else{
                        self.empty()
                        self.view.endEditing(true)
                    }
                })
            }
        }
    }
    
    func empty(){
        self.comentTextField.text = ""
    }
}

extension ComentViewController : UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableVW.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ComentTableViewCell
        let comment = comments[indexPath.row]
        let user = users[indexPath.row]
        cell.coment = comment
        cell.user = user
        return cell
    }
    
    
}
