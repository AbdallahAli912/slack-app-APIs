//
//  ChannelVC.swift
//  Chat-App
//
//  Created by Abdallah Ali on 9/13/19.
//  Copyright © 2019 Abdallah Ali. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       self.revealViewController()?.rearViewRevealWidth = self.view.frame.size.width - 60
    }
    


}
