//
//  LoginViewController.swift
//  SocialIo
//
//  Created by admin on 08/12/2020.
//  Copyright © 2020 Margarita Malnik. All rights reserved.
//

import UIKit
import FirebaseAuth
class LoginViewController: UIViewController {
   
    @IBOutlet weak var emailTv: UITextField!
    @IBOutlet weak var pwdTv: UITextField!
   
    
    
    @IBAction func login(_ sender: UIButton) {
     Model.instance.signInToFirebase(email:emailTv.text!, password:pwdTv.text!, callback: { (error: String?) in
               if error == nil{
                      
                        let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? UITabBarController
                        
                        self.view.window?.rootViewController = homeViewController
                        self.view.window?.makeKeyAndVisible()
            
                   }
           else{
                print("error");
        }

        })


    }}
