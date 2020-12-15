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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func register(_ sender: UIButton) {
   if (pswTv.text != pswTv.text) {
             let alertController = UIAlertController(title: "Password Incorrect", message: "Please re-type password", preferredStyle: .alert)
             let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                         
             alertController.addAction(defaultAction)
             self.present(alertController, animated: true, completion: nil)
    
         }
         else{
             let user = UserAuth(email:emailTv.text!,password:pswTv.text!,fullName: userTv.text!)
          
             Model.instance.createUserInFirebase(user: user, callback: { (error: String?) in
                 if (error == nil){
          print("Error")
                     }
                 else{
               self.performSegue(withIdentifier: "Profile", sender: self);
         }

                          })


                      }}
                     
}

