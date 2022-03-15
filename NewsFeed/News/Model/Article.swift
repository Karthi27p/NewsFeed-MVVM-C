//
//  Article.swift
//  NewsFeed
//
//  Created by karthi.palaniappan on 05/02/22.
//

import Foundation

struct Article: Codable, Hashable, Identifiable {
    var id = UUID()
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
    
    private enum CodingKeys: CodingKey {
        case author
        case title
        case description
        case url
        case urlToImage
        case publishedAt
        case content
    }
}
