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
   var modelSql:ModelSql = ModelSql()
    var modelFirebase:ModelFirebase = ModelFirebase()

    private init(){

    }
    
    func add(user:User){
     //   modelSql.add(user: user)
        modelFirebase.add(user: user);
        ModelEvents.UserDataNotification.post();
    }
    
    func getAllUsers(callback:@escaping
        ([User]?)->Void){
        //get  the local last update
        
        let lud=modelSql.getLastUpdateDate(name: "USERS")
        //get the records from fire base since the local last update date
        
        modelFirebase.getAllUsers(since:lud){ (stData) in
        
                //save  the new records to the local db
            var locaLud:Int64 = 0
            for user in stData!{
                self.modelSql.add(user:user)
                if (user.lastUpdated > locaLud){
                    locaLud=user.lastUpdated
                }
                
            }
                
                //save the new local last update date
            self.modelSql.setLastUpdateDate(name: "USERS", lud: locaLud)
                
                //get the complete data from the local db
            let completeData=self.modelSql.getAllUsers()
                //return the complete data to the caller
            callback(completeData);
        }
    }
   func saveImage(image:UIImage, callback: @escaping (String)->Void){
        FirebaseStorage.saveImage(image: image, callback: callback)
    }
       }

    class ModelEvents{
        static let UserDataNotification = ModelEventsTemplate(name: "com.company.UserDataNotification");
        static let LoginStateNotification = ModelEventsTemplate(name: "com.company.LoginStateNotification");
   static let GPSUpdateEvent = ModelEventsTemplateWithArgs<String>(name: "com.company.GPSUpdateEvent");
           static let UsersListUpdateEvent = ModelEventsTemplateWithArgs<[User]>(name: "com.company.UsersListUpdateEvent");
        
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
    ///
        
        ///
        class ModelEventsTemplateWithArgs<T>{
             let notificationName:String;
             
             init(name:String){
                 notificationName = name;
             }
             func observe(callback:@escaping (T)->Void)->Any{
                return NotificationCenter.default.addObserver(forName: NSNotification.Name(notificationName),
                                                               
                object: nil, queue: nil) { (data) in
                                                                let d:T = data.userInfo!["data"] as!
                    T;
                                                                callback(d);
                 }
             }
             
            func post(data:T){
                NotificationCenter.default.post(name: NSNotification.Name(notificationName), object: self,userInfo:["data":data]);
             }

}


