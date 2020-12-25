//
//  FirebaseStorage.swift
//  SocialIo
//
//  Created by admin on 17/06/2020.
//  Copyright © 2020 Margarita Malnik. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import CommonCrypto

class FirebaseStorage {
    static func saveImage(image:UIImage, callback:@escaping (String)->Void){
        let storageRef = Storage.storage().reference(forURL:
            "gs://socialio-c3892.appspot.com")
        
    
        
        let data = image.jpegData(compressionQuality: 0.5)
        let imageRef = storageRef.child("imageName")
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        imageRef.putData(data!, metadata: metadata) { (metadata, error) in
            imageRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    return
                }
                print("url: \(downloadURL)")
                callback(downloadURL.absoluteString)
            }
        }
  

       }
        static func deleteImage(image:UIImage, callback:@escaping (String)->Void){
             let storageRef = Storage.storage().reference(forURL:
                        "gs://socialio-c3892.appspot.com")
                      
             let desertRef = storageRef.child("imageName")
            desertRef.delete{ error in
                 if error != nil{
                     //error
                 }else{
                     //file deleted
                     
                 }
             }
        }
}
 
