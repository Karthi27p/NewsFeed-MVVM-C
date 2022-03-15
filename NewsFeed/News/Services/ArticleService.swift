//
//  ArticleService.swift
//  NewsFeed
//
//  Created by karthi.palaniappan on 05/02/22.
//

import Foundation
import Combine

struct ArticleService {
    
    func getArticles() -> AnyPublisher<NewsArticles, Error> {
        let urlRequest = URLRequest(url: URL(string: "https://newsapi.org/v2/everything?q=tesla&from=2022-03-15&sortBy=publishedAt&apiKey=\(PlistManager.apiKey)")!)
        return APIManager.callApi(requestUrl: urlRequest, resultStruct: NewsArticles.self)
    }
}

struct PlistManager {
     static var apiKey: String {
        get {
            guard let filePath = Bundle.main.path(forResource: "APIKey", ofType: "plist") else {
                fatalError("API KEY path not configured")
            }
            guard let plist = NSDictionary(contentsOfFile: filePath) else {
                fatalError("API KEY not configured")
            }
            guard let value = plist.value(forKey: "APIKey") as? String else {
                fatalError("API KEY not found")
            }
            return value
        }
    }
}
