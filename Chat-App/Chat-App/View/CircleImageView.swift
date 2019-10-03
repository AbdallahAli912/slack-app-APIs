//
//  CircleImageView.swift
//  Chat-App
//
//  Created by Abdallah Ali on 9/29/19.
//  Copyright © 2019 Abdallah Ali. All rights reserved.
//

import UIKit

@IBDesignable
class CircleImageView: UIImageView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }

    override func prepareForInterfaceBuilder() {
        setUpView()
    }
    func setUpView(){
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }
}
