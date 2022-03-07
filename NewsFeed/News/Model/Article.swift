//
//  Article.swift
//  NewsFeed
//
//  Created by karthi.palaniappan on 05/02/22.
//

import Foundation

struct Article: Codable, Hashable {
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}
