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
   
    
    static func factory()->LoginViewController{
    return UIStoryboard(name: "Main",bundle: nil).instantiateViewController(identifier: "LoginViewController")
    }
   override func viewDidLoad() {
        super.viewDidLoad()

    self.navigationItem.hidesBackButton = true
    
    let newBackButton=UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.back(sender:)))
    self.navigationItem.leftBarButtonItem = newBackButton
        }

    @objc func back(sender:UIBarButtonItem){
      //  performSegue(withIdentifier: "cancelLoginSegue", sender: self)
          self.navigationController?.popViewController(animated: true);
      
    }
    
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
