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
                UINavigationControllerDelegate {
    
    @IBOutlet weak var picBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameTextView: UITextField!
    @IBOutlet weak var idTextView: UITextField!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
           activity.isHidden=true;
    }
  
    @IBAction func save(_ sender: UIButton) {
        activity.isHidden = false;
             saveBtn.isEnabled = false;
             picBtn.isEnabled = false;
             let st = User(id:self.idTextView.text!);
             st.name = self.nameTextView.text!
             guard let selectedImage = selectedImage else {
                 Model.instance.add(user: st);
                 self.navigationController?.popViewController(animated: true);
                 return;
             }

             Model.instance.saveImage(image: selectedImage) { (url) in
                 st.avatar = url;
                 Model.instance.add(user: st);
                 self.navigationController?.popViewController(animated: true);
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

}
