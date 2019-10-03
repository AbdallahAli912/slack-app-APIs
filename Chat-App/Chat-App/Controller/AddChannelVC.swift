//
//  AddChannelVC.swift
//  Chat-App
//
//  Created by Abdallah Ali on 10/2/19.
//  Copyright © 2019 Abdallah Ali. All rights reserved.
//

import UIKit

class AddChannelVC: UIViewController {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var channelNameTxt: UITextField!
    @IBOutlet weak var channelDesTxt: UITextField!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }


    @IBAction func createChannelBtnPressed(_ sender: Any) {
        spinner.isHidden = false
        spinner.startAnimating()
        
        guard let name = channelNameTxt.text , channelNameTxt.text != "" else {
            spinner.isHidden = true
            spinner.stopAnimating()
            return
        }
        
        guard let des = channelDesTxt.text , channelDesTxt.text != "" else {
            spinner.isHidden = true
            spinner.stopAnimating()
            return
        }
        
        SocketService.instance.addChannel(ChannelName: name, ChannelDesc: des) { (success) in
            self.spinner.stopAnimating()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    
    @IBAction func closePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
 
    
    
    func setUpViews()  {
        
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(AddChannelVC.closeTap))
        bgView.addGestureRecognizer(closeTouch)
        
        spinner.isHidden = true
        channelNameTxt.attributedPlaceholder = NSAttributedString(string: "name", attributes: [NSAttributedString.Key.foregroundColor : placeholderColor ])
        channelDesTxt.attributedPlaceholder = NSAttributedString(string: "description", attributes: [NSAttributedString.Key.foregroundColor : placeholderColor ])
    }
    
    @objc func closeTap(_ recoginzer : UITapGestureRecognizer)  {
        dismiss(animated: true, completion: nil)
    }
}
