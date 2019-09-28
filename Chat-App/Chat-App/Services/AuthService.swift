//
//  AuthService.swift
//  Chat-App
//
//  Created by Abdallah Ali on 9/27/19.
//  Copyright © 2019 Abdallah Ali. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AuthServise{
    static let instance = AuthServise()
    let defaults = UserDefaults.standard
    
    var isLoggedIn : Bool {
        get{
            return defaults.bool(forKey: LOGGED_IN_KEY)
        }
        
        set {
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
        }
    }
    
    var authToken : String {
        get{
            return defaults.value(forKey: TOKEN_KEY) as! String
        }
        
        set {
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
    }
    
    
    
    var userEmail : String {
        get{
            return defaults.value(forKey: USER_EMAIL) as! String
        }
        
        set {
            defaults.set(newValue, forKey: USER_EMAIL)
        }
    
    }
    
    
    func userRegister(email:String,password:String , complition: @escaping CompletionHandler )  {
        
        let lowerCasedEmail =  email.lowercased()
        let body : [String:Any] = [
            "email" : lowerCasedEmail,
            "password" : password
        ]
        
        Alamofire.request(REGISTER_URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseString { (response) in
            if response.result.error == nil{
                complition(true)
            }else{
                complition(false)
                debugPrint(response.result.error as Any)
            }
        
        }
        
        
    }
    
    
    func loginUser(email : String , password : String , completion : @escaping CompletionHandler){
        let lowerCasedEmail =  email.lowercased()
        let body : [String:Any] = [
            "email" : lowerCasedEmail,
            "password" : password
        ]
        
        Alamofire.request(LOGIN_URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            if response.result.error == nil{
                //old fashion json parsing
               // print("i'm in no error in loging ")
//                if let json = response.result.value as? Dictionary<String,Any>{
//                    if let email = json["user"] as? String{
//                        self.userEmail = email
//                    }
//
//                    if let token = json["token"] as? String{
//                        self.authToken = token
//                    }
//                }
                
                //using swifty JSON
                guard let data = response.data else {return}
                let json = JSON(data)
                self.userEmail = json["user"].stringValue
                self.authToken = json["token"].stringValue
                
                self.isLoggedIn = true
                completion(true)
            }else{
               // print("i'm in  error in loging ")
                completion(false)
                debugPrint(response.result.error as Any)
            }
            
            
        }
        }
        
   
    func createUser(name:String , email:String , avatarName :String , avatarColor :String ,completion : @escaping CompletionHandler){
        
        let lowerCasedEmail =  email.lowercased()
        
        let header = [
            "Authorization" : "Bearer \(AuthServise.instance.authToken)",
             "Content-Type" : "application/json; charset=utf-8"
        ]
        
        let body : [String:Any] = [
            "name" : name,
            "email" : lowerCasedEmail,
            "avatarName" : avatarName,
            "avatarColor" : avatarColor
        ]
        
        Alamofire.request(URL_USER_ADD, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            
            if response.result.error == nil{
                guard let data = response.data else{return}
                let json = JSON(data: data)
                
                let name = json["name"].stringValue
                let id = json["_id"].stringValue
                let email = json["email"].stringValue
                let avatarName = json["avatarName"].stringValue
                let avatarColor = json["avatarColor"].stringValue
                
                UserDataService.instance.setUserData(name: name, id: id, avatarName: avatarName, avatarColor: avatarColor, email: email)
                completion(true)
                
                
            }else{
                completion(false)
                print("i'm in error")
                debugPrint(response.result.error as Any)
            }
        }
        
    }
    
    
    
}
