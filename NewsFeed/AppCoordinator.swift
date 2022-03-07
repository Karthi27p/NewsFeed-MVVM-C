//
//  AppCoordinator.swift
//  NewsFeed
//
//  Created by karthi.palaniappan on 08/02/22.
//

import Foundation
import UIKit

class AppCoordinator: BaseCoordinator {
    let window: UIWindow?
    
    init(window: UIWindow) {
        self.window = window
    }
    
//    lazy var rootViewController: UINavigationController =  {
//        UINavigationController()
//    }()
    
    override func start() {
//        guard let window = window else {
//            return
//        }
//        window.rootViewController = rootViewController
//        window.makeKeyAndVisible()
        //showNewsFeedScreen()
        loadTabBar()
    }

//    func showNewsFeedScreen() {
//        let newsFeedCoordinator = NewsFeedCoordinator(navigationController: self.rootViewController)
//        self.addChildCoordinator(newsFeedCoordinator)
//        newsFeedCoordinator.start()
//    }
    
    func loadTabBar() {
        let tabBarCoordinator = TabBarCoordinator(window: self.window!)
        self.addChildCoordinator(tabBarCoordinator)
        tabBarCoordinator.start()
    }
}
