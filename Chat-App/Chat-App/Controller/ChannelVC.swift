//
//  ChannelVC.swift
//  Chat-App
//
//  Created by Abdallah Ali on 9/13/19.
//  Copyright © 2019 Abdallah Ali. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController ,UITableViewDataSource ,UITableViewDelegate {

    //IBOutlets
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var userImg: CircleImageView!
    @IBOutlet weak var channelsTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       self.revealViewController()?.rearViewRevealWidth = self.view.frame.size.width - 60
        
        //notifiction observer for user data
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_CHANGED, object: nil)
        channelsTable.dataSource = self
        channelsTable.delegate = self

         //notifiction observer for user data
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.channelsLoaded(_:)), name: NOTIF_CHANNELS_LOADED, object: nil)
        
        SocketService.instance.getChannel { (sucess) in
            self.channelsTable.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setUpUserData()
    }
    
    //IBActions
    @IBAction func loginBtnPressed(_ sender: Any) {
        if AuthServise.instance.isLoggedIn{
            let profile = ProfileVC()
            profile.modalPresentationStyle = .custom
            present(profile, animated: true, completion: nil)
        }else{
        performSegue(withIdentifier: TO_LOGIN, sender: nil)
        }
    }
    
    @IBAction func perpareForUnwind(segue : UIStoryboardSegue){}

    @IBAction func addChannelBtnPressed(_ sender: Any) {
        
        if AuthServise.instance.isLoggedIn{
            let addChannelVc = AddChannelVC()
            addChannelVc.modalPresentationStyle = .custom
            present(addChannelVc,animated: true,completion: nil)
        }
    }
    
    
    //notification selectors
    @objc func userDataDidChange(_ notif : Notification)  {
        setUpUserData()
    }
    
    @objc func channelsLoaded(_ notif : Notification)  {
        self.channelsTable.reloadData()
    }
    
    
    
    
 
    
    
    
    //table view protocols functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.channels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "channelCell", for: indexPath) as? ChannelCell{
            let channel = MessageService.instance.channels[indexPath.row]
            cell.configureCell(channel: channel)
            return cell
        }else{
            return ChannelCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedChannel = MessageService.instance.channels[indexPath.row]
        MessageService.instance.channelSelected = selectedChannel
        NotificationCenter.default.post(name: NOTIF_CHANNEL_SELECTED, object: nil)
        self.revealViewController()?.revealToggle(animated: true)
    }
    
    //helper functions
    func setUpUserData()  {
        if AuthServise.instance.isLoggedIn{
            loginBtn.setTitle(UserDataService.instance.name, for: .normal)
            userImg.image = UIImage(named: UserDataService.instance.avatarName)
            userImg.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
        }else{
            loginBtn.setTitle("login", for: .normal)
            userImg.image = UIImage(named: "menuProfileIcon")
            userImg.backgroundColor = UIColor.clear
            self.channelsTable.reloadData()
        }
    }
    
    
    

}
