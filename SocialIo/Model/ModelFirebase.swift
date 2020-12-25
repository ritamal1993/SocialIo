//
//  ModelFirebase.swift
//  SocialIo
//
//  Created by ЯНИНА on 10/03/2020.
//  Copyright © 2020 Margarita Malnik. All rights reserved.
//

import Foundation
import Firebase
import UIKit


class ModelFirebase{
    
    func add(user:User){
        let db = Firestore.firestore()
//        var ref: DocumentReference? = nil
        let json = user.toJson();
        db.collection("users").document(user.id).setData(json){
            err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
                ModelEvents.UserDataEvent.post();
            }
        }

    }
    
        func deletepost(user:User){
            let db = Firestore.firestore()
   
            db.collection("users").document(user.id).delete(){
                err in
                if let err = err {
                    print("Error removing document: \(err)")
                } else {
                    print("Document successfully removed!")
                   ModelEvents.UserDataEvent.post();
                }
            }

        }
    func updatePost(user:User){
           let db = Firestore.firestore()
        db.collection("users").document(user.id).updateData([
               "name" : user.name,
               "id" :user.id,
               "avatar" : user.avatar
           ]) { err in
               if let err = err {
                   print("Error updating document: \(err)")
               } else {
                   print("Document successfully updated")
               }
           }
       }
   
    func signInToFirebase(email:String, password:String, callback: @escaping (String?) -> ()) {
      Auth.auth().signIn(withEmail: email, password: password) { (FBuser, error) in
        if(error == nil) {
            callback(nil)
        }
        else{callback(error!.localizedDescription)}
      }
    }
    //FIRUser
    func createUserInFirebase(user:UserAuth, callback: @escaping (String?) -> ()) {
        Auth.auth().createUser(withEmail: user.email, password: user.password) { (newUser, error) in
            if(error == nil) {
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = user.fullName
                changeRequest!.commitChanges { err in
                    if (err == nil) {
                        callback(nil)
                    } else {
                        callback(err!.localizedDescription)
                    }
                  }
            }
            else{callback(error!.localizedDescription)}
        }
    }
  
    func getCurrentUserName() -> String?{
        return Auth.auth().currentUser?.displayName
    }
    func getCurrentUserEmail() -> String?{
        return Auth.auth().currentUser?.email
    }
    func getCurrentUserId() -> String?{
        return Auth.auth().currentUser?.uid
    }
    func areUserLoggedIn() -> Bool{
        if (Auth.auth().currentUser != nil){
            return true
        }
        return false
    }
    func logOut(){
      let firebaseAuth = Auth.auth()
       do {
           try firebaseAuth.signOut()
       } catch let signOutError as NSError {
           print ("Error signing out: %@", signOutError)
       }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //TODO: implement since
    func getAllUsers(since:Int64, callback: @escaping ([User]?)->Void){
        let db = Firestore.firestore()
        db.collection("users").order(by: "lastUpdated").start(at: [Timestamp(seconds: since, nanoseconds: 0)]).getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                callback(nil);
            } else {
                var data = [User]();
                for document in querySnapshot!.documents {
                    if let ts = document.data()["lastUpdated"] as? Timestamp{
                        let tsDate = ts.dateValue();
                        print("\(tsDate)");
                        let tsDouble = tsDate.timeIntervalSince1970;
                        print("\(tsDouble)");

                    }
                    data.append(User(json: document.data()));
                }
                callback(data);
            }
        };
    }
}
