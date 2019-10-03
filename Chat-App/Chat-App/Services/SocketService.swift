//
//  SocketService.swift
//  Chat-App
//
//  Created by Abdallah Ali on 10/2/19.
//  Copyright © 2019 Abdallah Ali. All rights reserved.
//

import UIKit
import SocketIO


class SocketService: NSObject {

    static let instance = SocketService()
    let manager : SocketManager
    let socket : SocketIOClient
    
    override init() {
        manager =  SocketManager(socketURL: URL(string: BASE_URL)!)
        socket = manager.defaultSocket
        super.init()
    }
    
    func establishConnection ()  {
        socket.connect()
    }
    
    func closeConnection()   {
        socket.disconnect()
    }
    
    
    //adding channel socket request
    
    func addChannel(ChannelName : String , ChannelDesc : String ,completion : @escaping CompletionHandler) {
        socket.emit("newChannel", ChannelName , ChannelDesc)
        completion(true)
    }
    
    func getChannel(completion : @escaping CompletionHandler)  {
        socket.on("channelCreated") { (dataArray, ack) in
            
            guard let name = dataArray[0] as? String else{return}
            guard let des = dataArray[1] as? String else{return}
            guard let id = dataArray[2] as? String else{return}
            
            let newChannel = Channel(title: name, description: des, id: id)
            MessageService.instance.channels.append(newChannel)
            completion(true)
        }
    }
    
    func AddMessage(messageBody:String , userId:String ,channelId:String ,completion :@escaping CompletionHandler){
        let user = UserDataService.instance
        socket.emit("newMessage", messageBody,userId,channelId,user.name,user.avatarName,user.avatarColor)
        completion(true)
    }
}
