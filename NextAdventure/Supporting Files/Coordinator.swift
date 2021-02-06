//
//  Coordinator.swift
//  NextAdventure
//
//  Created by Aliaksandr Drankou on 06.02.2021.
//

import UIKit

protocol Coordinator{
    var navigationController: UINavigationController { get set }
    var childCoordinators: [Coordinator] {get set}
    
    func start()
}
