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
        let secondTabCoordinator = getSecondCoordinator()
        tabBarController.setViewControllers([newsFeedCoordinator.navigationController, secondTabCoordinator.navigationController], animated: false)
        self.addChildCoordinator(newsFeedCoordinator)
        self.addChildCoordinator(secondTabCoordinator)
        tabBarController.setTitle(tabBarItemTitles: [("News", "Tesla"), ("Second", "")])
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
    
    func getNewsFeedCoordinator() -> NewsFeedCoordinator {
        let newsFeedCoordinator = NewsFeedCoordinator(navigationController: UINavigationController())
        newsFeedCoordinator.start()
        return newsFeedCoordinator
    }
    
    func getSecondCoordinator() -> SecondTabCoordinator {
        let secondCoordinator = SecondTabCoordinator(navigationController: UINavigationController())
        secondCoordinator.start()
        return secondCoordinator
    }
}

