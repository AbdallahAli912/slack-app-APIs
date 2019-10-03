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
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    //Variables
     var avatarName = "profileDefault"
     var avatarColor = "[0.5, 0.5, 0.5, 1]"
     var bgColor : UIColor?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpviews()
       

    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDataService.instance.avatarName != ""{
            avatarImg.image = UIImage(named: UserDataService.instance.avatarName)
            avatarName = UserDataService.instance.avatarName
        }
        
        if avatarName.contains("light") && bgColor == nil{
            avatarImg.backgroundColor = UIColor.lightGray
        }
    }
    
    
    @IBAction func createAccPressed(_ sender: Any) {
        
        spinner.isHidden = false
        spinner.startAnimating()
        
        guard let email = emailTxt.text , emailTxt.text != "" else{return}
        guard let pass = passTxt.text , passTxt.text != "" else {return}
        guard let name = usernameTxt.text , usernameTxt.text != "" else {return}
        
        
        AuthServise.instance.userRegister(email: email, password: pass) { (succes) in
            if succes {
               // print("registerd successfuly")
                AuthServise.instance.loginUser(email: email, password: pass, completion: { (succes) in
                    if succes{
                      //   print("logged successfuly")
                        AuthServise.instance.createUser(name: name, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor, completion: { (succes) in
                            if succes{
                                self.spinner.isHidden = true
                                self.spinner.stopAnimating()
                               self.performSegue(withIdentifier: UNWIND, sender: nil)
                                NotificationCenter.default.post(name: NOTIF_USER_DATA_CHANGED, object: nil)
                            }
                        })
                    }
                })
            }
        }
        
    }
    
    @IBAction func pickAvatarPressed(_ sender: Any) {
        
        performSegue(withIdentifier: TO_AVATAR_PICKER, sender: nil)
    }
    
    @IBAction func pickBgColor(_ sender: Any) {
        let r = CGFloat(arc4random_uniform(255))/255
        let g = CGFloat(arc4random_uniform(255))/255
        let b = CGFloat(arc4random_uniform(255))/255
        bgColor = UIColor(red: r, green: g, blue: b, alpha: 1)
        avatarColor = "[\(r), \(g), \(b), 1]"
        UIView.animate(withDuration: 0.2){
            self.avatarImg.backgroundColor = self.bgColor
        }
        
    }
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
    func setUpviews(){
        
         spinner.isHidden = true
        usernameTxt.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedString.Key.foregroundColor : placeholderColor])
        
        emailTxt.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSAttributedString.Key.foregroundColor : placeholderColor])
        passTxt.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedString.Key.foregroundColor : placeholderColor])
        
        let tap = UITapGestureRecognizer(target: self, action: #selector (CreateAccountVC.handleTap))
        view.addGestureRecognizer(tap)
    }
    @objc func handleTap(){
        view.endEditing(true)
    }

}
