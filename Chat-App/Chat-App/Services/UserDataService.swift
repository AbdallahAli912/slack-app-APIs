//
//  UserDataService.swift
//  Chat-App
//
//  Created by Abdallah Ali on 9/28/19.
//  Copyright © 2019 Abdallah Ali. All rights reserved.
//

import Foundation

class UserDataService{
    static let instance =  UserDataService()
    
    public private(set) var name = ""
    public private(set) var id = ""
    public private(set) var avatarName = ""
    public private(set) var avatarColor = ""
    public private(set) var email = ""
    
    func setUserData(name : String, id : String, avatarName:String, avatarColor:String, email:String){
        self.name = name
        self.email = email
        self.avatarColor = avatarColor
        self.avatarName = avatarName
        self.id = id
    }
    
    func setAvatarName(avatarName: String)  {
        self.avatarName = avatarName
    }
}
