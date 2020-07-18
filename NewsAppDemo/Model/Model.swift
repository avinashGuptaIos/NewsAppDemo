//
//  Model.swift
//  NewsAppDemo
//
//  Created by hasher on 13/07/20.
//  Copyright © 2020 Avinash. All rights reserved.
//

import Foundation

struct NewsResponse: Decodable {
    var articles: [Article]?
    var status: String?
    var totalResults: Int?
}

struct Article: Decodable {
    var author, title, description, urlToImage: String?
}
