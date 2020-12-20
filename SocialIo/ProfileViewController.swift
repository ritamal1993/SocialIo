//
//  ProfileViewController.swift
//  SocialIo
//
//  Created by admin on 09/12/2020.
//  Copyright © 2020 Margarita Malnik. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var userName: UILabel!
    @IBAction func logout(_ sender: Any) {
       Model.instance.logOut()
            let start = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.start) as? UINavigationController
                            
                            self.view.window?.rootViewController = start
                            self.view.window?.makeKeyAndVisible()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       self.userName.text = Model.instance.getCurrentUserName()
    }
    

}

