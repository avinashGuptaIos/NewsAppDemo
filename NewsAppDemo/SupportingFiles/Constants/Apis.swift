//
//  Apis.swift
//  NewsAppDemo
//
//  Created by hasher on 12/07/20.
//  Copyright © 2020 Avinash. All rights reserved.
//

import Foundation

//MARK: Singletons

let Shared_CustomJsonEncoder = CustomJsonEncoder.shared.getSharedEncoder()
class CustomJsonEncoder {
   private var jsonEncoder: JSONEncoder
    private init(){ jsonEncoder = JSONEncoder() }
    static let shared = CustomJsonEncoder()
    
    func getSharedEncoder() -> JSONEncoder {
        return jsonEncoder
    }
}

let Shared_CustomJsonDecoder = CustomJsonDecoder.shared.getSharedDecoder()
class CustomJsonDecoder {
   private var jsonDecoder: JSONDecoder
    private init(){ jsonDecoder = JSONDecoder() }
    static let shared = CustomJsonDecoder()
    
    func getSharedDecoder() -> JSONDecoder {
        return jsonDecoder
    }
}

//MARK:- App APIS

let BASE_URL = "https://newsapi.org/\(version)"
let version = "v2"
let GET_TopHeadlines = "/top-headlines"

func convertQueriedFormURLfromParams(param: [String:Any]) -> String{
    var components = URLComponents()
    components.queryItems = param.map {
     URLQueryItem(name: $0, value: "\($1)")
    }
    guard let queryParams = components.url else { return "" }
    
    return "\(queryParams)"
}


func GET_NEWS(page: Int) -> String {
    let keysDict = [ "country" : "us",
                     "category" : "technology",
                     "apiKey" : API_KEY,
                     "pageSize" : pageSize,
                     "page" : page] as [String : Any]
   return "\(GET_TopHeadlines)\(convertQueriedFormURLfromParams(param: keysDict))"
}

func START_LOADING_VIEW()  {
    if Utils.isInternetAvailable() {
        DispatchQueue.main.async {
            let loadingView = LoadingView()
            loadingView.tag = LOADING_VIEW_TAG
            APP_KEY_WINDOW?.addSubview(loadingView)
            loadingView.startAnimation()
        }
    }
    else
    {
        STOP_LOADING_VIEW()
    }
}

func STOP_LOADING_VIEW()  {
    DispatchQueue.main.async {
        let loadingView = APP_KEY_WINDOW?.viewWithTag(LOADING_VIEW_TAG) as? LoadingView
        loadingView?.stopAnimation()
    }
}
