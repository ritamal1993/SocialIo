//
//  ProfileViewController.swift
//  SocialIo
//
//  Created by admin on 09/12/2020.
//  Copyright © 2020 Margarita Malnik. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController,LoginViewControllerDelegate {
    func onLoginSuccess() {
        
    }
    
    func onLoginCancele() {
        self.tabBarController?.selectedIndex = 0;
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
   if(!Model.instance.isLoggedIn()){
                       let loginVc = LoginViewController.factory();
                loginVc.delegate=self
                       show(loginVc, sender: self)
                   
  
        }
    
    }

}

