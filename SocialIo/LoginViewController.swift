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
   
       @IBOutlet weak var activity: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
         activity.isHidden = true;
         pwdTv.isSecureTextEntry = true;
        // Do any additional setup after loading the view.
    }
    @IBAction func login(_ sender: UIButton) {
       
         
        activity.isHidden = false;
       
     Model.instance.signInToFirebase(email:emailTv.text!, password:pwdTv.text!, callback: { (error: String?) in
               if error == nil{
                      
                        let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? UITabBarController
                        
                        self.view.window?.rootViewController = homeViewController
                        self.view.window?.makeKeyAndVisible()
            
                   }
           else{
                print("error");
                let alert = UIAlertController(title: "Error!!!", message: "email or password incorrect", preferredStyle: UIAlertController.Style.alert)
                             alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                             self.present(alert,animated:true,completion: nil)
        }

        })


    }}
