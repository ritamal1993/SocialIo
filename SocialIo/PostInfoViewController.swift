//
//  ViewController.swift
//  SocialIo
//
//  Created by Margarita Malnik on 06/03/2020.
//  Copyright © 2020 Margarita Malnik. All rights reserved.
//

import UIKit

import Kingfisher
class PostInfoViewController: UIViewController{
   var post : Post?

    @IBOutlet weak var avatarImg: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var activity: UIActivityIndicatorView!

    @IBOutlet weak var userid: UILabel!
    
    @IBOutlet weak var postid: UILabel!
    
    @IBOutlet weak var editBtn: UIBarButtonItem!
    

    @IBOutlet weak var deleteBtn: UIButton!
    
    
        override func viewDidLoad() {
        super.viewDidLoad()
            activity.isHidden = true;
        self.userid.text = post!.userid
        self.postid.text = post!.id
            
            if (self.userid.text != Model.instance.getCurrentUserId()) {
                  self.editBtn.isEnabled = false
                  self.editBtn.tintColor = UIColor.clear
            
            }
         
            self.nameLabel.text = post!.name
          
            self.idLabel.text = post!.post
           
            self.avatarImg.image = UIImage(named: "avatar")
            if(self.post!.avatar != ""){
            avatarImg.kf.setImage(with: URL(string: post!.avatar));
        
       

    }
            
        }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if (segue.identifier == "EditPost") {
             if let nav = segue.destination as? UINavigationController,
                let vc = nav.topViewController as? NewPostViewController {
               vc.post = self.post
             }
         }

    }
    var selectedImage:UIImage?
               


    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
                selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage;
            self.avatarImg.image = selectedImage;
                dismiss(animated: true, completion: nil);
       }
         
           
    
     
            @IBAction func deletep(_ sender: Any) {
                if (self.userid.text == Model.instance.getCurrentUserId()){
                    
                 let alert = UIAlertController(title: "You are about to delete this post!", message: "Are you sure?", preferredStyle: .alert)
                                
                                alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
                                    Model.instance.deletepost(post:self.post!)
                                    self.activity.isHidden=false
                                    self.deleteBtn.isHidden=false
                                    ModelEvents.DeleteDataEvent.post();
                                                          self.navigationController?.popViewController(animated: true);
                                }));
                                
                                alert.addAction(UIAlertAction(title: "No", style: .default, handler: { action in
                                    return;
                                }));
                                
                                self.present(alert, animated: true)
                            }else{
                                return
                            }
                        }
                    }
                    
              

       





