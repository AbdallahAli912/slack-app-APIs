//
//  CreateAccountVC.swift
//  Chat-App
//
//  Created by Abdallah Ali on 9/24/19.
//  Copyright © 2019 Abdallah Ali. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {
    
    //IBOutlets
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passTxt: UITextField!
    @IBOutlet weak var avatarImg: UIImageView!
    
    //Variables
     let avatarName = "profileDefault"
     let avatarColor = "[0.5, 0.5, 0.5, 1]"
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func createAccPressed(_ sender: Any) {
        guard let email = emailTxt.text , emailTxt.text != "" else{return}
        guard let pass = passTxt.text , passTxt.text != "" else {return}
        guard let name = usernameTxt.text , usernameTxt.text != "" else {return}
        
        
        AuthServise.instance.userRegister(email: email, password: pass) { (succes) in
            if succes {
                AuthServise.instance.loginUser(email: email, password: pass, completion: { (succes) in
                    if succes{
                        AuthServise.instance.createUser(name: name, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor, completion: { (succes) in
                            if succes{
                                print(UserDataService.instance.name , UserDataService.instance.avatarName)
                               self.performSegue(withIdentifier: UNWIND, sender: nil)
                            }
                        })
                    }
                })
            }
        }
        
    }
    
    @IBAction func pickAvatarPressed(_ sender: Any) {
    }
    
    @IBAction func pickBgColor(_ sender: Any) {
    }
    
    
    
    
    
    
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    

}
