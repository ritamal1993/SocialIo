//
//  Model.swift
//  SocialIo
//
//  Created by ЯНИНА on 10/03/2020.
//  Copyright © 2020 Margarita Malnik. All rights reserved.
//


import Foundation
import UIKit

class Model {
    static let instance = Model()
    
    var modelFirebase:ModelFirebase = ModelFirebase()
    
    private init(){
    }
    
    func add(user: User){
        modelFirebase.add(user: user);
    }
    
    func getAllUsers(callback:@escaping ([User]?)->Void){
        
        //get the local last update date
       let last = User.getLastUpdateDate();
        
       
        modelFirebase.getAllUsers(since:last) { (data) in
           
           var last:Int64 = 0;
            for user in data!{
               user.addToDb()
                if user.lastUpdated! > last {last = user.lastUpdated!  }
            }
          //  update the local last update date
            User.setLastUpdate(lastUpdated: last)
           //  get the complete list
            let finalData = User.getAllUsersFromDb()
            callback(finalData);
        }
    }

    func saveImage(image:UIImage, callback:@escaping (String)->Void) {
        FirebaseStorage.saveImage(image: image, callback: callback)
    }
    
    
    ////// user Autantication ////////
    var logedIn = false;
    func isLoggedIn()->Bool{
        return logedIn
    }
    func logIn(email:String,pwd:String,callback:(Bool)->Void){
        
        logedIn = true;
        callback(true);
    }
    func logout(){
  
   logedIn=false;
    }
    func register(user:String,email:String,pwd:String,callback:(Bool)->Void){
    
    logedIn = true;
    callback(true);
        
    }
}
class ModelEvents{
    static let UserDataEvent = EventNotificationBase(eventName: "com.company.UserDataEvent");
    static let LoggingStateChangeEvent = EventNotificationBase(eventName: "com.company.LoggingStateChangeEvent");
    
    static let CommentsDataEvent = StringEventNotificationBase<String>(eventName: "com.company.CommentsDataEvent");
    private init(){}
}

class EventNotificationBase{
    let eventName:String;
    
    init(eventName:String){
        self.eventName = eventName;
    }
    
    func observe(callback:@escaping ()->Void){
        NotificationCenter.default.addObserver(forName: NSNotification.Name(eventName),
                                               object: nil, queue: nil) { (data) in
                                                callback();
        }
    }
    
    func post(){
        NotificationCenter.default.post(name: NSNotification.Name(eventName),
                                        object: self,
                                        userInfo: nil);
    }
}

class StringEventNotificationBase<T>{
    let eventName:String;
    
    init(eventName:String){
        self.eventName = eventName;
    }
    
    func observe(callback:@escaping (T)->Void){
        NotificationCenter.default.addObserver(forName: NSNotification.Name(eventName),
                                               object: nil, queue: nil) { (data) in
                                                let strData = data.userInfo!["data"] as! T
                                                callback(strData);
        }
    }
    
func post(data:T){
        NotificationCenter.default.post(name: NSNotification.Name(eventName),
                                        object: self,
                                        userInfo: ["data":data]);
    }
}
