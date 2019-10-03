//
//  MessageService.swift
//  Chat-App
//
//  Created by Abdallah Ali on 10/1/19.
//  Copyright © 2019 Abdallah Ali. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessageService{
    static let  instance = MessageService()
    
    var channels = [Channel]()
    var messages = [Message]()
    var channelSelected : Channel?
    
    func getChannels(completion : @escaping CompletionHandler){
        Alamofire.request(URL_GET_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BAREAR_HEADER).responseJSON { (response) in
            if response.result.error == nil{
                guard let data = response.data else{return}
                
                //decoder conversion of json array of objects
                // 1-adjust naming convention in the model first
                // 2-make model conform to Decodable protocool
                // 3- uncomment those lines 
//                do {
//                    self.channels = try JSONDecoder().decode([Channel].self, from: data)
//                } catch let error{
//                    debugPrint(error as Any)
//                }
//                print(self.channels)
//                completion(true)
                
                // old way to convert array of json object
                if let json = JSON(data).array {
                    for item in json{
                        let name = item["name"].stringValue
                        let description = item["description"].stringValue
                        let id  = item["_id"].stringValue
                        let channel = Channel(title: name, description: description, id: id)
                        self.channels.append(channel)
                    }
                    
                    NotificationCenter.default.post(name: NOTIF_CHANNELS_LOADED, object: nil)
                    completion(true)
                }

            }else{
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func getMessageForChannel( withId id : String , completion : @escaping CompletionHandler){
        Alamofire.request("\(URL_GET_MESSAGES)\(id)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BAREAR_HEADER).responseJSON { (response) in
            if response.result.error == nil{
                self.clearMessages()
                guard let data = response.data else {return}
                if let json = JSON(data).array{
                    for item in json{
                          let messageBody = item["messageBody"].stringValue
                          let channelId = item["channelId"].stringValue
                          let id = item["_id"].stringValue
                          let userName = item["userName"].stringValue
                          let userAvatar = item["userAvatar"].stringValue
                          let userAvatarColor = item["userAvatarColor"].stringValue
                          let timeStamp = item["timeStamp"].stringValue
                        let message = Message(message: messageBody, userName: userName, channelId: channelId, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: id, timeStamp: timeStamp)
                        self.messages.append(message)
                        
                    }
                }
                
                print(self.messages)
                completion(true)
                
            }else{
                debugPrint(response.result.error as Any)
            }
        }
        
    }
    
    func clearMessages(){
        self.messages.removeAll()
    }
    func clearChannels(){
        self.channels.removeAll()
    }
    
    
}
