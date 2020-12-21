//
//  ViewController.swift
//  SocialIo
//
//  Created by Margarita Malnik on 06/03/2020.
//  Copyright © 2020 Margarita Malnik. All rights reserved.
//

import UIKit

import Kingfisher
class UserInfoViewController: UIViewController {
   var user : User?

    @IBOutlet weak var avatarImg: UIImageView!
    

    @IBOutlet weak var nameLabel: UILabel!
    

    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var editBtn: UIBarButtonItem!
    //  @IBOutlet weak var editBtn: UIBarButtonItem!
    
        override func viewDidLoad() {
        super.viewDidLoad()
        
        if (self.user?.id != Model.instance.getCurrentUserId()) {
                  // self.editBtn.isEnabled = false
                  // self.editBtn.tintColor = UIColor.clear
            self.navigationItem.rightBarButtonItem=self.editBtn
            }
            self.nameLabel.text = user!.name
            self.idLabel.text = user!.id
            self.avatarImg.image = UIImage(named: "avatar")
            if(self.user!.avatar != ""){
            avatarImg.kf.setImage(with: URL(string: user!.avatar));
        
        

    }
        }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if (segue.identifier == "EditPost") {
             if let nav = segue.destination as? UINavigationController,
                let vc = nav.topViewController as? NewUserViewController {
               vc.user = self.user
             }
         }

    }
   // override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       //     if (segue.identifier == "UserInfoSegue"){
             //   let vc:UserInfoViewController = segue.destination as! //UserInfoViewController
               /// vc.user = selected
           // }
        //}
}
