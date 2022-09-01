//
//  Firebase.swift
//  SampleMVVMApp
//
//  Created by mtanaka on 2022/08/31.
//

import Firebase
import FirebaseAuth
import FirebaseFirestore

final class Firebase {
    
    private static let auth = Auth.auth()
    private static let db = Firestore.firestore()
    
    static func registerAuth(mail: String, password: String, completion: @escaping (Result<String, Error>) -> ()) {
        
        auth.createUser(withEmail: mail, password: password) { res, err in
            
            if let err = err {
                print("認証情報の保存に失敗しました。\(err)")
                completion(.failure(err))
                return
            }
            
            guard let uid = res?.user.uid else { return }
            completion(.success(uid))
        }
    }
    
    static func emailAuth(mail: String, completion: @escaping (_ err: Error?) -> ()) {
        
        auth.languageCode = "ja_JP"
        auth.currentUser?.sendEmailVerification { err in
            if let err = err {
                print("認証メールの送信に失敗しました。\(err)")
                completion(err)
                return
            }
            
            completion(nil)
        }
    }
    
    static func registerUser(userName: String, mail: String, uid: String, completion: @escaping (_ err: Error?) -> ()) {
        
        let docDate: [String : Any] = ["userName": userName, "mail": mail, "uid": uid, "createdAt": Timestamp()]
        db.collection("users").document(uid).setData(docDate) { err in
            
            if let err = err {
                print("Firestoreへの保存に失敗しました。\(err)")
                completion(err)
                return
            } else {
                
                completion(nil)
            }
        }
    }
}
