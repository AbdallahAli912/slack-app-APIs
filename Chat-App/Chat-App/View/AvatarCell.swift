//
//  AvatarCell.swift
//  Chat-App
//
//  Created by Abdallah Ali on 9/28/19.
//  Copyright © 2019 Abdallah Ali. All rights reserved.
//

import UIKit

enum AvatarType{
    case dark
    case light
}

class AvatarCell: UICollectionViewCell {
    
    
    @IBOutlet weak var avatarImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    func configurecell(index : Int, avatarType:AvatarType){
        
        if avatarType == AvatarType.dark{
            avatarImg.image = UIImage(named: "dark\(index)")
            self.layer.backgroundColor = UIColor.lightGray.cgColor
        } else{
            avatarImg.image = UIImage(named: "light\(index)")
            self.layer.backgroundColor = UIColor.gray.cgColor
        }
    }
    
    
    
    
    func setUpView()  {
        self.layer.cornerRadius = 10
        self.layer.backgroundColor = UIColor.lightGray.cgColor
        self.clipsToBounds = true
    }
}
