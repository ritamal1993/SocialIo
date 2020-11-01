//
//  Model.swift
//  SocialIo
//
//  Created by ЯНИНА on 10/03/2020.
//  Copyright © 2020 Margarita Malnik. All rights reserved.
//


import Foundation
import Firebase
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
        ModelEvents.UserDataNotification.post();
    }
    
    func getAllUsers(callback:@escaping
        ([User]?)->Void){
        modelFirebase.getAllUsers(callback: callback);
     //  return modelSql.getAllUsers()
      //  modelFirebase.getAllUsers();
    }
   func saveImage(image:UIImage, callback: @escaping (String)->Void){
        FirebaseStorage.saveImage(image: image, callback: callback)
    }
       }

    class ModelEvents{
        static let UserDataNotification = ModelEventsTemplate(name: "com.company.UserDataNotification");
        static let LoginStateNotification = ModelEventsTemplate(name: "com.company.LoginStateNotification");

        
        static func removeObserver(observer:Any){
            NotificationCenter.default.removeObserver(observer)
        }
        private init(){}
    }

    class ModelEventsTemplate{
        let notificationName:String;
        
        init(name:String){
            notificationName = name;
        }
        func observe(callback:@escaping ()->Void)->Any{
            return NotificationCenter.default.addObserver(forName: NSNotification.Name(notificationName),
                                                          object: nil, queue: nil) { (data) in
                                                            callback();
            }
        }
        
        func post(){
            NotificationCenter.default.post(name: NSNotification.Name(notificationName), object: self,userInfo:nil);
        }

    
}
