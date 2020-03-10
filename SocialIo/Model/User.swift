//
//  User.swift
//  SocialIo
//
//  Created by ЯНИНА on 10/03/2020.
//  Copyright © 2020 Margarita Malnik. All rights reserved.
//

import Foundation

import Foundation

class User {
    var id:String = ""
    var name:String = ""
    var avatar:String = ""
    
    init(id:String, name:String, avatar:String){
        self.id = id
        self.name = name
        self.avatar = avatar
    }
    
    init(json:[String:Any]){
        self.id = json["id"] as! String;
        self.name = json["name"] as! String;
        self.avatar = json["avatar"] as! String;
    }
    
    func toJson() -> [String:String] {
        var json = [String:String]();
        json["id"] = id
        json["name"] = name
        json["avatar"] = avatar
        return json;
    }
    
}
