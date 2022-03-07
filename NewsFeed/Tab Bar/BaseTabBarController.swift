//
//  BaseTabBarController.swift
//  NewsFeed
//
//  Created by karthi.palaniappan on 14/02/22.
//

import Foundation
import UIKit

class BaseTabBarController: UITabBarController {
    func setTitle(tabBarItemTitles: [(String, String)]) {
        for (index, item) in tabBarItemTitles.enumerated() {
            self.tabBar.items?[index].title = item.0
            self.tabBar.items?[index].image = UIImage(named: item.1)
        }
    }
}
