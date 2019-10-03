//
//  LoginVC.swift
//  Chat-App
//
//  Created by Abdallah Ali on 9/13/19.
//  Copyright © 2019 Abdallah Ali. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    //IBOutlets
    
   
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passTxt: UITextField!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet weak var errorLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func closePrssed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createAccountPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_CREATE_ACCOUNT, sender: nil)
    }
    @IBAction func loginBtnPressed(_ sender: Any) {
        errorLbl.isHidden = true
        //wheel spinner
        spinner.isHidden = false
        spinner.startAnimating()
        
        guard let email = emailTxt.text , emailTxt.text != "" else{
            self.spinner.isHidden = true
            self.spinner.stopAnimating()
            return
        }
        guard let pass = passTxt.text , passTxt.text != "" else{
            self.spinner.isHidden = true
            self.spinner.stopAnimating()
            return
        }
        
        AuthServise.instance.loginUser(email: email, password: pass) {
            (succes) in
            if succes{
                AuthServise.instance.findUserByEmail(complition: {
                    (success) in
                    NotificationCenter.default.post(name: NOTIF_USER_DATA_CHANGED, object: nil)
                    self.spinner.isHidden = true
                    self.spinner.stopAnimating()
                     self.dismiss(animated: true, completion: nil)
                })
            }else{
                self.spinner.isHidden = true
                self.spinner.stopAnimating()
                self.emailTxt.text = ""
                self.passTxt.text = ""
                self.errorLbl.isHidden = false
            }
        }
    }
    
    func setUpViews(){
        spinner.isHidden = true
        errorLbl.isHidden = true
        emailTxt.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSAttributedString.Key.foregroundColor : placeholderColor ])
       passTxt.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedString.Key.foregroundColor : placeholderColor ])

    }
}
