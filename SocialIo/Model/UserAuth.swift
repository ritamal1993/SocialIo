//
//  UserAuth.swift
//  SocialIo
//
//  Created by admin on 14/12/2020.
//  Copyright © 2020 Margarita Malnik. All rights reserved.
//

import Foundation
class UserAuth {
  var email:String = ""
    var password:String = ""
    var fullName:String = ""

    init(email:String, password:String, fullName:String)
    {
        self.email = email
        self.password = password
        self.fullName = fullName
    }
}
