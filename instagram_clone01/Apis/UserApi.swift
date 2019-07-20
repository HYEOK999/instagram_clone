
import Foundation
import FirebaseDatabase

class UserApi{
    var REF_USERS = Database.database().reference().child("users")
    
    func observeUser(withId uid:String, completion:@escaping(UserModel) -> Void){
        REF_USERS.child(uid).observeSingleEvent(of: .value) { (snapshot) in
            if let dict = snapshot.value as? [String:Any]{
                let user = UserModel.transformUser(dict: dict)
                completion(user)
            }
        }
    }
}
