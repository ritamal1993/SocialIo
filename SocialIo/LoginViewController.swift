//
//  LoginViewController.swift
//  SocialIo
//
//  Created by admin on 08/12/2020.
//  Copyright © 2020 Margarita Malnik. All rights reserved.
//

import UIKit
protocol LoginViewControllerDelegate{
    func onLoginSuccess();
    func onLoginCancele();
}
class LoginViewController: UIViewController {
    var delegate:LoginViewControllerDelegate?
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
        if let delegate=delegate{
            delegate.onLoginCancele()
        }
    }
    
    @IBAction func login(_ sender: UIButton) {
        Model.instance.logIn(email: emailTv.text!, pwd: pwdTv.text!) {
            (success) in
            if(success)
                {
                        if let delegate=delegate{
                           delegate.onLoginSuccess()
            }
    }
    }
   

}
}
