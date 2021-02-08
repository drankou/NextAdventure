//
//  ViewController.swift
//  NextAdventure
//
//  Created by Aliaksandr Drankou on 06.02.2021.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController, CLLocationManagerDelegate {
    weak var coordinator: AppCoordinator?
    var locationManager = CLLocationManager()
    var userCoordinate: CLLocationCoordinate2D!

    override func loadView() {
        super.loadView()
        let view = HomeView(frame: UIScreen.main.bounds)
        view.exploreButton.addTarget(self, action: #selector(exploreButtonTapped), for: .touchUpInside)

        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.requestAlwaysAuthorization()
        switch locationManager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            if let currentLocation = locationManager.location {
                userCoordinate = currentLocation.coordinate
            } else {
                userCoordinate = CLLocationCoordinate2D(latitude: .zero, longitude: .zero)
            }
            
            //probably save last coordinates to UserDefaults
//            UserDefaults.standard.set(encodedLocation, forKey: "savedLocation")
        default:
            return
        }
    }
    
    @objc func exploreButtonTapped(){
        coordinator?.showFlights(userCoordinate: userCoordinate)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

