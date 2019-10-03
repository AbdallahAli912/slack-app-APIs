//
//  ChatVC.swift
//  Chat-App
//
//  Created by Abdallah Ali on 9/13/19.
//  Copyright © 2019 Abdallah Ali. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {
    
    //IBoutlets
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var channelNameLbl: UILabel!
    @IBOutlet weak var messageTxtBox: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //keyboard work pop up  and close
        view.bindToKeyboard()
        let tapToCloseKeyboard = UITapGestureRecognizer(target: self, action: #selector(ChatVC.tabEndEditing(_:)))
        view.addGestureRecognizer(tapToCloseKeyboard)
        
        //swreavl
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        //notification observers
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_CHANGED, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.selectChannel(_:)), name: NOTIF_CHANNEL_SELECTED, object: nil)
        
        
        
        if AuthServise.instance.isLoggedIn{
            AuthServise.instance.findUserByEmail { (succes) in
                NotificationCenter.default.post(name: NOTIF_USER_DATA_CHANGED, object: nil)
            }
            
        }
        
        
        
    }
    
    //notification selectors
    @objc func userDataDidChange(_ notif : Notification)  {
        if AuthServise.instance.isLoggedIn{
            onloginGetChannels()
        }else{
            channelNameLbl.text = "plz Login First!"
        }
        
    }
    
    
    @objc func selectChannel(_ notif : Notification) {
       updateWithChannel()
       
    }
    //IBActions
    
    @IBAction func sendBtnPressed(_ sender: Any) {
        
        if AuthServise.instance.isLoggedIn{
        guard let channelId = MessageService.instance.channelSelected?.id else{return}
        guard let message = messageTxtBox.text else{return}
        
        SocketService.instance.AddMessage(messageBody: message, userId: UserDataService.instance.id, channelId: channelId) { (success) in
            if success{
                self.messageTxtBox.text = ""
                self.messageTxtBox.resignFirstResponder()
            }
        }
            
        }
    }
    
    //helper functions
    
    @objc func tabEndEditing(_ recognizer : UITapGestureRecognizer)  {
        view.endEditing(true)
    }
    func onloginGetChannels()  {
        MessageService.instance.getChannels { (succes) in
            if succes{
                if MessageService.instance.channels.count > 0{
                    MessageService.instance.channelSelected = MessageService.instance.channels[0]
                    self.updateWithChannel()
                }else{
                   self.channelNameLbl.text = "No channels yet!"
                }
            }
        }
    }

    func updateWithChannel()  {
       let name = MessageService.instance.channelSelected?.title ?? ""
        channelNameLbl.text = "#\(name)"
        retriveMessages()
    }
    
    func retriveMessages()  {
        guard let channelId = MessageService.instance.channelSelected?.id else {return}
        MessageService.instance.getMessageForChannel(withId: channelId) { (success) in
            
        }
    }

}
