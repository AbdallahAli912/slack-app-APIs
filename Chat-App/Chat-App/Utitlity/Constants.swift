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
 let BASE_URL = "https://chattychatjp.herokuapp.com/v1/"
 let REGISTER_URL = "\(BASE_URL)account/register"
 let LOGIN_URL = "\(BASE_URL)account/login"
 let URL_USER_ADD = "\(BASE_URL)user/add"

let TO_LOGIN = "to_login"
let TO_CREATE_ACCOUNT = "toCreateAccount"
let UNWIND = "unwindToChannel"

//user defaults
let LOGGED_IN_KEY = "loggedIn"
let TOKEN_KEY = "token"
let USER_EMAIL = "userEmail"

//headers
let HEADER = [
    "Content-Type" : "application/json; charset=utf-8"
]
