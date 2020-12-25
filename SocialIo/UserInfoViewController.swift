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
      var selectedImage:UIImage?
            
            @IBAction func deletep(_ sender: Any) {
              
                 let alert = UIAlertController(title: "Delete!!!", message: "do you sure you want to delete this post?", preferredStyle: UIAlertController.Style.alert)
                                             alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                                             self.present(alert,animated:true,completion: nil)
                 
                 
                 let st = User(id:self.idLabel.text!)
               
                 st.name = self.nameLabel.text!
              
               Model.instance.deletepost(user:st)
           
            
            }
       
       
       func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage;
        self.avatarImg.image = selectedImage;
            dismiss(animated: true, completion: nil);
   }
     
       
}
