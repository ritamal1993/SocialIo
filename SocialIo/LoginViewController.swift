//
//  LoginViewController.swift
//  SocialIo
//
//  Created by admin on 08/12/2020.
//  Copyright © 2020 Margarita Malnik. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
   
    @IBOutlet weak var emailTv: UITextField!
    @IBOutlet weak var pwdTv: UITextField!
   
    
    
    @IBAction func login(_ sender: UIButton) {
     Model.instance.signInToFirebase(email:emailTv.text!, password:pwdTv.text!, callback: { (error: String?) in
               if error == nil{
                print("Error")
            
                   }
           else{
                self.performSegue(withIdentifier: "Profile", sender: self);
        }

        })


    }}
