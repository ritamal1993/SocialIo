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


    @IBOutlet weak var avatarImg: UIImageView!
    

    @IBOutlet weak var nameLabel: UILabel!
    

    @IBOutlet weak var idLabel: UILabel!
    

    
    var user:User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = user?.name
        idLabel.text = user?.id
        avatarImg.image = UIImage(named: "avatar")
        if(user?.avatar != ""){
            avatarImg.kf.setImage(with: URL(string: user!.avatar));
        }
        

    }
    
}


