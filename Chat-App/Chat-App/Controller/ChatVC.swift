//
//  ChatVC.swift
//  Chat-App
//
//  Created by Abdallah Ali on 9/13/19.
//  Copyright © 2019 Abdallah Ali. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {
    @IBOutlet weak var menuBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
       
    }
    


}
