//
//  Constants.swift
//  NewsAppDemo
//
//  Created by hasher on 12/07/20.
//  Copyright © 2020 Avinash. All rights reserved.
//

import Foundation
import UIKit

public class NameValueObject: NSObject
{
   public var name, value, objectType, valueUrlString: String?
    
   public init(_ name: String? = nil,_ value: String? = nil, _ objectType: String? = nil, _ valueUrlString: String? = nil) {
        self.name = name
        self.value = value
        self.objectType = objectType
        self.valueUrlString = valueUrlString
    }
    
}

//MARK: Others
let APP_KEY_WINDOW = UIWindow.key

let APP_DELEGATE = AppDelegate.shared

let GET_REQUEST = "GET"
let POST_REQUEST = "POST"
let PUT_REQUEST = "PUT"
let DELETE_REQUEST = "DELETE"

let API_KEY = "a8fabd9ff4234c82aad08eaaa4ea17a0"
let pageSize = 5

let SUCCESS_CODE = 200


let LOADING_VIEW_TAG = 123456789
let LOADING_IMAGE_TAG = 987654321

let BACKEND_ERROR = 9000
let NO_DATA_LABEL_TAG = 8999
