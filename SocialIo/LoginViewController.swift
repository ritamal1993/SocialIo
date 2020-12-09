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

   override func viewDidLoad() {
        super.viewDidLoad()

    self.navigationItem.hidesBackButton = true
    let newBackButton=UIBarButtonItem(title: "Cancle", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.back(sender:)))
    self.navigationItem.leftBarButtonItem = newBackButton
        }

    @objc func back(sender:UIBarButtonItem){
        performSegue(withIdentifier: "cancelLoginSegue", sender: self)
    }
    
    @IBAction func login(_ sender: UIButton) {
        Model.instance.logIn(email: emailTv.text!, pwd: pwdTv.text!) {
            (success) in
            if(success)
                {
                    self.navigationController?.popViewController(animated: true);
            }
    }
    }
   
}
