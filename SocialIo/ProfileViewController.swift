//
//  ProfileViewController.swift
//  SocialIo
//
//  Created by admin on 09/12/2020.
//  Copyright © 2020 Margarita Malnik. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    override func viewDidLoad() {
         super.viewDidLoad()


         if(!Model.instance.isLoggedIn()){
             let loginVc = UIStoryboard(name: "Main",bundle: nil).instantiateViewController(identifier: "LoginViewController")
             show(loginVc, sender: self)
        }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
}
