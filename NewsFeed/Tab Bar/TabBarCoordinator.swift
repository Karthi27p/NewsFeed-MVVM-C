//
//  TabBarCoordinator.swift
//  NewsFeed
//
//  Created by karthi.palaniappan on 14/02/22.
//

import Foundation
import UIKit

class TabBarCoordinator: BaseCoordinator {

    let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    private lazy var tabBarController: BaseTabBarController =  {
        BaseTabBarController()
    }()
    
    override func start() {
        let newsFeedCoordinator = getNewsFeedCoordinator()
        let topHeadlinesCoordinator = getTopHeadlinesCoordinator()
        tabBarController.setViewControllers([topHeadlinesCoordinator.navigationController, newsFeedCoordinator.navigationController], animated: false)
        self.addChildCoordinator(topHeadlinesCoordinator)
        self.addChildCoordinator(newsFeedCoordinator)
        tabBarController.setTitle(tabBarItemTitles: [("Top Headlines", "News"), ("News", "Tesla")])
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
    
    func getNewsFeedCoordinator() -> NewsFeedCoordinator {
        let newsFeedCoordinator = NewsFeedCoordinator(navigationController: UINavigationController())
        newsFeedCoordinator.start()
        return newsFeedCoordinator
    }
    
    func getTopHeadlinesCoordinator() -> TopHeadlinesCoordinator {
        let topHeadlinesCoordinator = TopHeadlinesCoordinator(navigationController: UINavigationController())
        topHeadlinesCoordinator.start()
        return topHeadlinesCoordinator
    }
}

