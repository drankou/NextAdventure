//
//  AppCoordinator.swift
//  NextAdventure
//
//  Created by Aliaksandr Drankou on 06.02.2021.
//

import UIKit

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = HomeViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
}
