//
//  ChannelCell.swift
//  Chat-App
//
//  Created by Abdallah Ali on 10/1/19.
//  Copyright © 2019 Abdallah Ali. All rights reserved.
//

import UIKit

class ChannelCell: UITableViewCell {

    @IBOutlet weak var ChannelTitle: UILabel!
    
    func configureCell(channel :Channel ) {
       let title = channel.title ?? ""
        ChannelTitle.text = "#\(title)"
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected{
            self.layer.backgroundColor = UIColor(white: 1, alpha: 0.2).cgColor
        }else{
            self.layer.backgroundColor = UIColor.clear.cgColor
        }
    }

}
