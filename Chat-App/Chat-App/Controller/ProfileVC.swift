//
//  ProfileVC.swift
//  Chat-App
//
//  Created by Abdallah Ali on 9/30/19.
//  Copyright © 2019 Abdallah Ali. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
 //IBOutlets
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var BgView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()

    }

    
    
    
    @IBAction func logoutBtnPressed(_ sender: Any) {
        UserDataService.instance.logoutUser()
        NotificationCenter.default.post(name: NOTIF_USER_DATA_CHANGED, object: nil)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func closeBtnPresed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func setUpViews(){
        profileImg.image = UIImage(named:UserDataService.instance.avatarName)
        profileImg.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
        usernameLbl.text = UserDataService.instance.name
        emailLbl.text = UserDataService.instance.email
        let closeTouch =  UITapGestureRecognizer(target: self, action: #selector(ProfileVC.closeTap(_:)))
        BgView.addGestureRecognizer(closeTouch)
    }
   
    @objc func closeTap(_ recognizer : UITapGestureRecognizer){
        dismiss(animated: true, completion: nil)
    }

}
