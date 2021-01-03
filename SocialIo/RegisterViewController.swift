//
//  RegisterViewController.swift
//  SocialIo
//
//  Created by admin on 08/12/2020.
//  Copyright © 2020 Margarita Malnik. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTv: UITextField!
    @IBOutlet weak var userTv: UITextField!
    @IBOutlet weak var pswTv: UITextField!
      @IBOutlet weak var activity: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
activity.isHidden = true;
         pswTv.isSecureTextEntry = true;
        // Do any additional setup after loading the view.
    }
    
    @IBAction func register(_ sender: UIButton) {

      activity.isHidden = false;
       
             let user = UserAuth(email:emailTv.text!,password:pswTv.text!,fullName: userTv.text!)
          
             Model.instance.createUserInFirebase(user: user, callback: { (error: String?) in
                 if (error == nil){
                    let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? UITabBarController
                    
                    self.view.window?.rootViewController = homeViewController
                    self.view.window?.makeKeyAndVisible()
         
                     }
                 else{
                 print("Error")
                    let alert = UIAlertController(title: "Error!!!", message: "email exists or password smaller then 6 characters", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert,animated:true,completion: nil)
         }

                          })


                      }}
                     


