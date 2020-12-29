//
//  User.swift
//  SocialIo
//
//  Created by ЯНИНА on 10/03/2020.
//  Copyright © 2020 Margarita Malnik. All rights reserved.
//



import Foundation
import Firebase

class User {
    let id:String
    var name:String = ""
    var avatar:String = ""
    var post:String = ""
    var userid:String = ""
    var lastUpdated: Int64?
    
    init(id:String){
        self.id = id
    }
}
