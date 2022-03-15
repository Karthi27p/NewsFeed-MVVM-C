//
//  HeadlinesViewModel.swift
//  NewsFeed
//
//  Created by karthi.palaniappan on 15/03/22.
//

import Foundation
import Combine
import SwiftUI

enum ApiType: String {
    case techCrunch = "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey="
    case buisnessHeadlines = "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey="
}

class HeadlinesViewModel: ObservableObject {
    @Published var articles = [Article]()
    var selectedArticle: Article?
    
    @available(iOS 15.0, *) func loadData(apiType: ApiType) async -> Void {
        let url = URL(string: apiType.rawValue+PlistManager.apiKey)
        let result = await APIService.callApi(url: url!, resultStruct: NewsArticles.self)
        switch result {
        case .success(let newsArticles):
            DispatchQueue.main.async {
                self.articles = newsArticles.articles ?? [Article]()
            }
        case .failure:
           break
       }
    }
}
