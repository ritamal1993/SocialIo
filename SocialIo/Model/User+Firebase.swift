//
//  User+Firebase.swift
//  SocialIo
//
//  Created by admin on 26/11/2020.
//  Copyright © 2020 Margarita Malnik. All rights reserved.
//
import Foundation
import Firebase

extension User{
    convenience init(json:[String:Any]){
        let id = json["id"] as! String;
        self.init(id:id)

        name = json["name"] as! String;
        avatar = json["avatar"] as! String;
        let ts = json["lastUpdated"] as! Timestamp
        lastUpdated = ts.seconds
    }
    
    func toJson() -> [String:Any] {
        var json = [String:Any]();
        json["id"] = id
        json["name"] = name
        json["avatar"] = avatar
        json["lastUpdated"] = FieldValue.serverTimestamp()
        return json;
    }
    
}
