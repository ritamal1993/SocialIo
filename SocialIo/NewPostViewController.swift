//
//  NewUserViewController.swift
//  SocialIo
//
//  Created by admin on 17/06/2020.
//  Copyright © 2020 Margarita Malnik. All rights reserved.
//

import UIKit

class NewPostViewController: UIViewController,
                UIImagePickerControllerDelegate,
                UINavigationControllerDelegate{
  
    @IBOutlet weak var picBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var activity: UIActivityIndicatorView!
   
    
      var post : Post?
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var userTextid: UILabel!
   
    
    
    @IBOutlet weak var nameTextView: UITextField!
    @IBOutlet weak var PostView: UITextField!

    
    @IBOutlet weak var PostTextid: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activity.isHidden = true;
        if (post != nil) {
                   self.initForm()
               }
        if(post == nil){
              self.PostTextid.text = UUID().uuidString
    }
              self.userTextid.text=Model.instance.getCurrentUserId()

    }
        
        override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated);
       
    }
    
    
        
          
    @IBAction func save(_ sender: UIButton) {
             activity.isHidden = false;
             saveBtn.isEnabled = false;
        picBtn.isEnabled = false;
          
        
             let st = Post(id:self.PostTextid.text!);
    
              st.name = self.nameTextView.text!
              st.post = self.PostView.text!
              st.userid = self.userTextid.text!
             guard let selectedImage = selectedImage else {
                 Model.instance.add(post: st);
                self.navigationController?.dismiss(animated: true, completion: nil);
                 return;
             }

             Model.instance.saveImage(image: selectedImage) { (url) in
                 st.avatar = url;
                 Model.instance.add(post: st);
              
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
         self.userTextid.text=self.post?.userid
     
        self.nameTextView.text=self.post?.name
        self.PostView.text=self.post?.post
        
        self.PostTextid.text=self.post?.id
      
        if (!self.post!.avatar.isEmpty) {
                     let url = URL(string: self.post!.avatar)
        self.picBtn.kf.setBackgroundImage(with: url, for: .normal)
        self.picBtn.setImage(nil, for: .normal)
        }
    }
}
