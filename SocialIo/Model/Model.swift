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
    
    func add(post: Post){
        modelFirebase.add(post: post);
    }
    func getpostOfCurrentUser(callback: @escaping ([Post]?)->Void){
          modelFirebase.getpostOfCurrentUser(callback: callback);
      }
    func getAllPosts(callback:@escaping ([Post]?)->Void){
        
        //get the local last update date
        let last = Post.getLastUpdateDate();
        modelFirebase.getAllPosts(since:last) { (data) in
           var last:Int64 = 0;
            
            for post in data!{
                  post.addToDb()
                if post.lastUpdated! > last {
                    last = post.lastUpdated!
                  
                }
            }
          //  update the local last update date
            Post.setLastUpdate(lastUpdated: last)
          //  get the complete list
            let finalData = Post.getAllPostsFromDb()
            callback(finalData);
        }
    }

    func saveImage(image:UIImage, callback:@escaping (String)->Void) {
        FirebaseStorage.saveImage(image: image, callback: callback)
    }
    
    
    ////// user Autantication ////////
   
  
    
    func signInToFirebase(email:String, password:String ,callback:@escaping (String?)->()){
        
          modelFirebase.signInToFirebase(email: email, password: password,callback: callback)
      
      }
      func createUserInFirebase(user:UserAuth,callback:@escaping (String?)->()){
           
          modelFirebase.createUserInFirebase(user: user,callback: callback)
      }
      func areUserLoggedIn() -> Bool{
          return modelFirebase.areUserLoggedIn()
      }
      func logOut(){
          modelFirebase.logOut()
   
      }
      func getCurrentUserEmail()->String?{
          modelFirebase.getCurrentUserEmail()
      }
      func getCurrentUserName()->String?{
          modelFirebase.getCurrentUserName()
      }
      func getCurrentUserId()->String?{
          modelFirebase.getCurrentUserId()
      }
    ////////////////////////////////////////////////////////////
   
    func deletepost(post: Post){
           
            modelFirebase.deletepost(post: post)
            Post.delete(post: post)
            ModelEvents.DeleteDataEvent.post();
    }
        
              
          
}
   
   
    ////////////////////////////////////////////////////////////

class ModelEvents{
    static let UserDataEvent = EventNotificationBase(eventName: "com.company.UserDataEvent");
    static let LoggingStateChangeEvent = EventNotificationBase(eventName: "com.company.LoggingStateChangeEvent");
        static let DeleteDataEvent = EventNotificationBase(eventName: "com.company.LoggingStateChangeEvent");
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
