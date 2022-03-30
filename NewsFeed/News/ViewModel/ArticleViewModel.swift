//
//  ArticleViewModel.swift
//  NewsFeed
//
//  Created by karthi.palaniappan on 05/02/22.
//

import Foundation
import Combine
import UIKit

protocol NewsCoordniatorDelegate: AnyObject {
    func showArticleDetailScreen(article: ArticleItem, image: UIImage)
}

struct ArticleItem: Hashable {
    let id = UUID()
    let title: String?
    let description: String?
    let urlToImage: String?
    let url: String?
    var image: UIImage!
}

class ArticleViewModel {
    var arrArticles = [ArticleItem]()
    let articles = CurrentValueSubject<[ArticleItem], Never>([])
    var cancellable: AnyCancellable?
    private weak var coordinatorDelegate: NewsCoordniatorDelegate?
    
    init(coordinatorDelegate: NewsCoordniatorDelegate?) {
        self.coordinatorDelegate = coordinatorDelegate
    }
    
    func getArticles() {
        let cancelable = ArticleService().getArticles().receive(on: RunLoop.main).sink(receiveCompletion: {_ in }) { [weak self] (result) in
            
            guard let strongSelf = self, let receivedArticles = result.articles else {
                return
            }
            strongSelf.arrArticles = receivedArticles.map( { article in
                ArticleItem(title: article.title, description: article.description, urlToImage: article.urlToImage, url: article.url, image: nil)
            } )
            strongSelf.articles.send(strongSelf.arrArticles)
        }
        self.cancellable = cancelable
    }
    
    func showArticleDetail(indexPath: IndexPath, image: UIImage) {
        coordinatorDelegate?.showArticleDetailScreen(article: arrArticles[indexPath.row], image: image)
    }
}
