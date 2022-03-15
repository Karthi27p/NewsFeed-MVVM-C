//
//  BuisnessHeadlinesCoordinator.swift
//  NewsFeed
//
//  Created by karthi.palaniappan on 16/03/22.
//

import Foundation
import UIKit

@available(iOS 15.0, *)
class BuisnessHeadlinesCoordinator: BaseCoordinator {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    private lazy var buisnessHeadlinesViewController: BuisnessHeadlinesViewController? = {
        UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "BuisnessHeadlinesViewController") as? BuisnessHeadlinesViewController
    }()
    
    override func start() {
        if let buisnessHeadlinesViewController = self.buisnessHeadlinesViewController {
            navigationController.setViewControllers([buisnessHeadlinesViewController], animated: false)
            navigationController.navigationBar.isHidden = true
        }
    }
}
