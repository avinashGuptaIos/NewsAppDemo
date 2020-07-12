//
//  NewsViewController.swift
//  NewsAppDemo
//
//  Created by hasher on 12/07/20.
//  Copyright © 2020 Avinash. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        ServiceManager.shared.methodType(requestType: GET_REQUEST, url: GET_NEWS(page: 1), params: nil, paramsData: nil, completion: { (response, responseData, statusCode) in
            print("News response is \(response)")
        }) { (response, statusCode) in
            print("Something wrong happened \(response)")
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
