//
//  ViewController.swift
//  SocialIo
//
//  Created by Margarita Malnik on 06/03/2020.
//  Copyright © 2020 Margarita Malnik. All rights reserved.
//

import UIKit

import Kingfisher
class UserInfoViewController: UIViewController{
   var user : User?

    @IBOutlet weak var avatarImg: UIImageView!
    

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var idLabel: UILabel!
    
     @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var userid: UILabel!
    
   
    
    @IBOutlet weak var postid: UILabel!
    
    
    @IBOutlet weak var editBtn: UIBarButtonItem!
    //  @IBOutlet weak var editBtn: UIBarButtonItem!
    
        override func viewDidLoad() {
        super.viewDidLoad()
            activity.isHidden = true;
        self.userid.text = user!.userid
        self.postid.text = user!.id
            
            if (self.userid.text != Model.instance.getCurrentUserId()) {
                  self.editBtn.isEnabled = false
                  self.editBtn.tintColor = UIColor.clear
                 
         // self.navigationItem.rightBarButtonItem=self.editBtn
            }
          //  self.userid.isEnabled=false
           //  self.userid.tintColor = UIColor.clear
          //  self.postid.isEnabled=false
            // self.postid.tintColor = UIColor.clear
            self.nameLabel.text = user!.name
          
            self.idLabel.text = user!.post
           
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
      var selectedImage:UIImage?
            
            @IBAction func deletep(_ sender: Any) {
              
             activity.isHidden = false;
                if (self.userid.text == Model.instance.getCurrentUserId()){
                 let st = User(id:self.postid.text!)
                 st.name = self.nameLabel.text!
                 st.post=self.idLabel.text!
                 st.userid=self.userid.text!
                 Model.instance.deletepost(user:st)
           
            let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? UITabBarController
                                  
                                  self.view.window?.rootViewController = homeViewController
                                  self.view.window?.makeKeyAndVisible()
                      
            }
    }
       
       
       func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage;
        self.avatarImg.image = selectedImage;
            dismiss(animated: true, completion: nil);
   }
     
       
}
