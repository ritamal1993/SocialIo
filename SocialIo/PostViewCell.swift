//
//  UserTableViewCell.swift
//  SocialIo
//
//  Created by ЯНИНА on 10/03/2020.
//  Copyright © 2020 Margarita Malnik. All rights reserved.
//

import UIKit

class PostViewCell: UITableViewCell {

  
    @IBOutlet weak var name: UILabel!
    
     @IBOutlet weak var idLabel: UILabel!
     
     @IBOutlet weak var avatarImg: UIImageView!
     

   
    override func awakeFromNib() {
         super.awakeFromNib()
         // Initialization code
     }

     override func setSelected(_ selected: Bool, animated: Bool) {
         super.setSelected(selected, animated: animated)

         // Configure the view for the selected state
     }
}
