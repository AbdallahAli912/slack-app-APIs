//
//  Constants.swift
//  Chat-App
//
//  Created by Abdallah Ali on 9/13/19.
//  Copyright © 2019 Abdallah Ali. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ succes :  Bool) ->()

//URL constants
 let BASE_URL = "https://apiforchattychat.herokuapp.com/v1/"
 let REGISTER_URL = "\(BASE_URL)account/register"
 let LOGIN_URL = "\(BASE_URL)account/login"
 let URL_USER_ADD = "\(BASE_URL)user/add"
 let URL_USER_BY_EMAIL = "\(BASE_URL)user/byEmail/"
 let URL_GET_CHANNELS = "\(BASE_URL)channel/"
let URL_GET_MESSAGES  = "\(BASE_URL)message/byChannel/"
let URL_ADD_CHANNEL = "\(BASE_URL)channel/add"

//colors
let placeholderColor = #colorLiteral(red: 0.3568627451, green: 0.6235294118, blue: 0.7960784314, alpha: 0.5)

//notification constants
 let NOTIF_USER_DATA_CHANGED = Notification.Name("notifUserDataChanged")
 let NOTIF_CHANNELS_LOADED = Notification.Name("notifChannelLoaded")
 let NOTIF_CHANNEL_SELECTED = Notification.Name("notifChannelSelected")

//segues
let TO_LOGIN = "to_login"
let TO_CREATE_ACCOUNT = "toCreateAccount"
let UNWIND = "unwindToChannel"
let TO_AVATAR_PICKER = "toAvatarPicker"

//user defaults
let LOGGED_IN_KEY = "loggedIn"
let TOKEN_KEY = "token"
let USER_EMAIL = "userEmail"

//headers
let HEADER = [
    "Content-Type" : "application/json; charset=utf-8"
]
let BAREAR_HEADER = [
    "Authorization" : "Bearer \(AuthServise.instance.authToken)",
    "Content-Type" : "application/json; charset=utf-8"
]
