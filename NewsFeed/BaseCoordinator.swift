//
//  BaseCoordinator.swift
//  NewsFeed
//
//  Created by karthi.palaniappan on 08/02/22.
//

import Foundation

protocol Coordinator: AnyObject {
    func start()
    func addChildCoordinator(_ coordinator: Coordinator)
    func removeChildCoordinator(_ coordinator: Coordinator)
    func removeAllChildCoordinators()
}

class BaseCoordinator: Coordinator {

    private(set) var childCoordinators: [Coordinator] = []
    
    func start() {
        preconditionFailure("This method needs to be overriden by concrete subclass.")
    }
    
    func addChildCoordinator(_ coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }
    
    func removeChildCoordinator(_ coordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(where: { $0 === coordinator}) {
            childCoordinators.remove(at: index)
        }
    }
    
    func removeAllChildCoordinators() {
        childCoordinators.removeAll()
    }
    
}
