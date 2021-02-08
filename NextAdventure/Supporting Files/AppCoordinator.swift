//
//  AppCoordinator.swift
//  NextAdventure
//
//  Created by Aliaksandr Drankou on 06.02.2021.
//

import UIKit
import CoreLocation

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
    
    func showFlights(userCoordinate: CLLocationCoordinate2D) {
        let resultsVC = ResultsViewController()
        resultsVC.coordinator = self
        resultsVC.userCoordinate = userCoordinate
        navigationController.pushViewController(resultsVC, animated: true)
    }
    
    func showFlightDetail(for flight: Flight) {
        let flightDetailVC = FlightDetailViewController()
        flightDetailVC.coordinator = self
        flightDetailVC.flight = flight
        navigationController.pushViewController(flightDetailVC, animated: true)
    }
}
