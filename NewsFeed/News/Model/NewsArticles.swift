//
//  NewsArticles.swift
//  NewsFeed
//
//  Created by karthi.palaniappan on 09/02/22.
//

import Foundation

struct NewsArticles: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]?
}
