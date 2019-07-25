
import Foundation
import FirebaseDatabase
import FirebaseAuth

class UserApi{
    var REF_USERS = Database.database().reference().child("users")
    
    func observeUser(withId uid:String, completion:@escaping(UserModel) -> Void){
        REF_USERS.child(uid).observeSingleEvent(of: .value) { (snapshot) in
            if let dict = snapshot.value as? [String:Any]{
                let user = UserModel.transformUser(dict: dict,  key: snapshot.key)
                completion(user)
            }
        }
    }
    
    
    func observeCurrentUser(completion:@escaping(UserModel) -> Void){
        guard let currentUser = Auth.auth().currentUser else {
            return
        }// 현재 유저 체크
        
        REF_USERS.child(currentUser.uid).observeSingleEvent(of: .value) { (snapshot) in
            if let dict = snapshot.value as? [String:Any]{
                let user = UserModel.transformUser(dict: dict, key: snapshot.key)
                completion(user)
            }
        }
    }
    
    func observeUsers(complection:@escaping(UserModel) -> Void) {
        REF_USERS.observe(.childAdded) { (snapshot) in
            if let dict  = snapshot.value as? [String:Any]{
                let user =  UserModel.transformUser(dict: dict,  key: snapshot.key)
                complection(user)
            }
        }
    }
    
    var CURRENT_USER : User? {
        if let currentUser = Auth.auth().currentUser {
            return currentUser
        }
        
        return nil
    }//FIREBASE에서 제공하는 USER
    
    var REF_CURRENT_USER : DatabaseReference? {
        guard let currentUser = Auth.auth().currentUser else {
            return nil
        }
        
        return REF_USERS.child(currentUser.uid)
    }
    
}//end
