//
//  SecondTabCoordinator.swift
//  NewsFeed
//
//  Created by karthi.palaniappan on 14/02/22.
//

import Foundation
import UIKit

class SecondTabCoordinator: BaseCoordinator {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    private lazy var secondViewController: SecondViewController? = {
        UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "SecondViewController") as? SecondViewController
    }()
    
    override func start() {
        if let secondViewController = self.secondViewController {
            navigationController.setViewControllers([secondViewController], animated: false)
        }
    }
}
