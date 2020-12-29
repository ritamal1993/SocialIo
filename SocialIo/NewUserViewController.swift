//
//  NewUserViewController.swift
//  SocialIo
//
//  Created by admin on 17/06/2020.
//  Copyright © 2020 Margarita Malnik. All rights reserved.
//

import UIKit

class NewUserViewController: UIViewController,
                UIImagePickerControllerDelegate,
                UINavigationControllerDelegate{
  
    @IBOutlet weak var picBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var activity: UIActivityIndicatorView!
   
    
      var user : User?
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var userTextid: UILabel!
   
    
    
    @IBOutlet weak var nameTextView: UITextField!
    @IBOutlet weak var PostView: UITextField!

    
    @IBOutlet weak var PostTextid: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
activity.isHidden = true;
        if (user != nil) {
                   self.initForm()
               }
        if(user == nil){
              self.PostTextid.text = UUID().uuidString
    }
              self.userTextid.text=Model.instance.getCurrentUserId()
        self.PostTextid.isEnabled=false
        self.PostTextid.tintColor = UIColor.clear
        self.userTextid.isEnabled=false
        self.userTextid.tintColor = UIColor.clear
    }
        
        override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated);
       
    }
    
    
        
          
    @IBAction func save(_ sender: UIButton) {
        activity.isHidden = false;
             saveBtn.isEnabled = false;
             picBtn.isEnabled = false;
          
        
             let st = User(id:self.PostTextid.text!);
    
              st.name = self.nameTextView.text!
              st.post = self.PostView.text!
              st.userid = self.userTextid.text!
             guard let selectedImage = selectedImage else {
                 Model.instance.add(user: st);
                 self.navigationController?.popViewController(animated: true);
                 return;
             }

             Model.instance.saveImage(image: selectedImage) { (url) in
                 st.avatar = url;
                 Model.instance.add(user: st);
              self.navigationController?.dismiss(animated: true, completion: nil);
             }
    }
    
    @IBAction func takePic(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerController.SourceType.photoLibrary) {
           let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
           imagePicker.sourceType =
            UIImagePickerController.SourceType.photoLibrary;
           imagePicker.allowsEditing = true
           self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    var selectedImage:UIImage?
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage;
        self.avatarImageView.image = selectedImage;
        dismiss(animated: true, completion: nil);
    }

    private func initForm(){
         self.userTextid.text=self.user?.userid
     
        self.nameTextView.text=self.user?.name
        self.PostView.text=self.user?.post
        
        self.PostTextid.text=self.user?.id
      
        if (!self.user!.avatar.isEmpty) {
                     let url = URL(string: self.user!.avatar)
        self.picBtn.kf.setBackgroundImage(with: url, for: .normal)
        self.picBtn.setImage(nil, for: .normal)
        }
    }
}
