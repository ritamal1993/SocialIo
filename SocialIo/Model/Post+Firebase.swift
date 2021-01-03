//
//  User+Firebase.swift
//  SocialIo
//
//  Created by admin on 26/11/2020.
//  Copyright © 2020 Margarita Malnik. All rights reserved.
//
import Foundation
import Firebase

extension Post{
    convenience init(json:[String:Any]){
        let id = json["id"] as! String;
        self.init(id:id)

        name = json["name"] as! String;
        avatar = json["avatar"] as! String;
        post = json["post"] as! String;
        userid = json["userid"] as! String;
        let ts = json["lastUpdated"] as! Timestamp
        lastUpdated = ts.seconds
    }
    
    func toJson() -> [String:Any] {
        var json = [String:Any]();
        json["id"] = id
        json["name"] = name
        json["avatar"] = avatar
        json["post"] = post
        json["userid"] = userid
        json["lastUpdated"] = FieldValue.serverTimestamp()
        return json;
    }
    
}
