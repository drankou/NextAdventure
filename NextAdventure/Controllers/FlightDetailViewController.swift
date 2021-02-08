//
//  FlightDetailViewController.swift
//  NextAdventure
//
//  Created by Aliaksandr Drankou on 08.02.2021.
//

import UIKit
import Combine

class FlightDetailViewController: UIViewController {

    weak var coordinator: AppCoordinator?
    var flight: Flight!
    var flightDetailView: FlightDetailView!
    var subscriptions = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        loadDetails()
    }
    
    private func configureView() {
        flightDetailView = FlightDetailView(frame: view.bounds)
        flightDetailView.cityFromLabel.text = flight.cityFrom
        flightDetailView.cityToLabel.text = flight.cityTo

        view.addSubview(flightDetailView)
    }
    
    private func loadDetails() {
        self.showActivityIndicator(view: view)
        ImageCache.publicCache.loadImage(from: .photos(imageId: flight.destinationID, resolution: .high))
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] (image) in
                self.flightDetailView.flightImageView.image = image
                self.hideActivityIndicator()
            }.store(in: &self.subscriptions)
    }
}
