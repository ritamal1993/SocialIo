//
//  Model.swift
//  SocialIo
//
//  Created by ЯНИНА on 10/03/2020.
//  Copyright © 2020 Margarita Malnik. All rights reserved.
//


import Foundation

class Model {
    static let instance = Model()
    
    
//    var modelSql:ModelSql = ModelSql()
    var modelFirebase:ModelFirebase = ModelFirebase()

    private init(){
//        modelSql.connect()
//        for i in 0...5{
//            let st = User(id: String(i),name: "name " + String(i),avatar: "")
//            add(user: st)
//        }
    }
    
    func add(user:User){
//        modelSql.add(user: user)
        modelFirebase.add(user: user);
    }
    
    func getAllUsers(callback:@escaping ([User]?)->Void){
        modelFirebase.getAllUsers(callback: callback);
//        return modelSql.getAllUsers()
//        modelFirebase.getAllUsers();
    }
    
}
