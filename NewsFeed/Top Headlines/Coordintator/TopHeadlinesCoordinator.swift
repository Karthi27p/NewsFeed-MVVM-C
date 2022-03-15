//
//  TopHeadlinesCoordinator.swift
//  NewsFeed
//
//  Created by karthi.palaniappan on 14/02/22.
//

import Foundation
import UIKit

class TopHeadlinesCoordinator: BaseCoordinator {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    private lazy var topHeadlinesViewController: TopHeadlinesViewController? = {
        UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "TopHeadlinesViewController") as? TopHeadlinesViewController
    }()
    
    override func start() {
        if let topHeadlinesViewController = self.topHeadlinesViewController {
            navigationController.setViewControllers([topHeadlinesViewController], animated: false)
            navigationController.navigationBar.isHidden = true
        }
    }
}
