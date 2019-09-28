//
//  RoundedBtn.swift
//  Chat-App
//
//  Created by Abdallah Ali on 9/28/19.
//  Copyright © 2019 Abdallah Ali. All rights reserved.
//

import UIKit
@IBDesignable
class RoundedBtn: UIButton {
    @IBInspectable var cornerRaduis : CGFloat = 3.0{
        didSet{
            self.layer.cornerRadius = cornerRaduis
        }
    }
   
    override func awakeFromNib() {
        customizeView()
    }
    override func prepareForInterfaceBuilder() {
        customizeView()
    }
    
    func customizeView(){
        self.layer.cornerRadius = cornerRaduis
    }
}
