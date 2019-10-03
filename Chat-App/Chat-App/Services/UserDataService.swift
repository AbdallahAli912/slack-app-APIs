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
    
    func returnUIColor(components : String) -> UIColor{
        // "[0.16862745098039217, 0.984313725490196, 0.6274509803921569, 1]"
        let scanner = Scanner(string: components)
        let skipped = CharacterSet(charactersIn: "[], ")
        let comma =  CharacterSet(charactersIn: ",")
        
        scanner.charactersToBeSkipped = skipped
        
        var r,g,b,a :NSString?
        
        //scanning
        scanner.scanUpToCharacters(from: comma, into: &r)
        scanner.scanUpToCharacters(from: comma, into: &g)
        scanner.scanUpToCharacters(from: comma, into: &b)
        scanner.scanUpToCharacters(from: comma, into: &a)
        
        let defaultColor = UIColor.lightGray
        
        //unwrapping
        guard let rUnWrapped = r else {return defaultColor}
        guard let gUnWrapped = g else {return defaultColor}
        guard let bUnWrapped = b else {return defaultColor}
        guard let aUnWrapped = a else {return defaultColor}


        //conversion to CGFloat
        let rFloat = CGFloat(rUnWrapped.doubleValue)
        let gFloat = CGFloat(gUnWrapped.doubleValue)
        let bFloat = CGFloat(bUnWrapped.doubleValue)
        let aFloat = CGFloat(aUnWrapped.doubleValue)

        
        let newColor = UIColor(red: rFloat, green: gFloat, blue: bFloat, alpha: aFloat)
        return newColor
    }
    
    func logoutUser()  {
        id = ""
        name = ""
        email = ""
        avatarName = ""
        avatarColor = ""
        AuthServise.instance.isLoggedIn = false
        AuthServise.instance.authToken = ""
        AuthServise.instance.userEmail = ""
        MessageService.instance.clearChannels()
    }
}
