//
//  NewsFeedCoordinator.swift
//  NewsFeed
//
//  Created by karthi.palaniappan on 08/02/22.
//

import Foundation
import UIKit

/*
 Communication between view model and coordinator should take place via delegate
 Communication between coordinator and parent coordinator should take place via delegate (Remove child view controller from stack from where its loaded when its no longer needed)
 */

class NewsFeedCoordinator: BaseCoordinator {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    private lazy var newsFeedViewController: NewsFeedViewController? = {
        UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "NewsFeedViewController") as? NewsFeedViewController
    }()
    
    override func start() {
        if let newsFeedViewController = self.newsFeedViewController {
            let articleViewModel = ArticleViewModel(coordinatorDelegate: self)
            newsFeedViewController.articleViewModel = articleViewModel
            navigationController.setViewControllers([newsFeedViewController], animated: false)
        }
    }
}

extension NewsFeedCoordinator: NewsCoordniatorDelegate {
    func showArticleDetailScreen(article: ArticleItem, image: UIImage) {
        if let articleDetailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ArticleDetailViewController") as? ArticleDetailViewController {
            articleDetailViewController.articleUrl = article.url ?? ""
            articleDetailViewController.itemsToShare = [article.title ?? "", URL(string: article.url ?? "")!, image]
            navigationController.pushViewController(articleDetailViewController, animated: true)
        }
    }
}
