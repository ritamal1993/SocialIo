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
        // Add a new document with a generated ID
        var ref: DocumentReference? = nil
        ref = db.collection("users").addDocument(data: user.toJson(), completion: { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added with ID: \(ref!.documentID)")
                }
        })
    }
    //todo complite since implemention
    func getAllUsers(since:Int64,callback: @escaping ([User]?)->Void){
        let db = Firestore.firestore()
        db.collection("users").getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                callback(nil);
            } else {
                var data = [User]();
                for document in querySnapshot!.documents {
                    data.append(User(json: document.data()));
                }
                callback(data);
            }
        };
    }
}
