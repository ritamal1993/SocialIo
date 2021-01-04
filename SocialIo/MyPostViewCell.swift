//
//  MyPostViewCell.swift
//  SocialIo
//
//  Created by admin on 30/12/2020.
//  Copyright © 2020 Margarita Malnik. All rights reserved.
//

import UIKit

class MyPostViewCell: UITableViewCell {



    
    @IBOutlet weak var imageview: UIImageView!
    
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var postview: UILabel!
    
    
    @IBOutlet weak var userid: UILabel!
    
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

