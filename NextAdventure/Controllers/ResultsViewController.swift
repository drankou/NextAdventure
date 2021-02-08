//
//  ResultsViewController.swift
//  NextAdventure
//
//  Created by Aliaksandr Drankou on 06.02.2021.
//

import UIKit
import CoreLocation
import Combine

class ResultsViewController: UIViewController {
    typealias CollectionDataSource = UICollectionViewDiffableDataSource<Section, Flight>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Flight>
    
    enum Section {
        case main
    }
        
    weak var coordinator: AppCoordinator?
    var collectionView: UICollectionView!
    var userCoordinate: CLLocationCoordinate2D!
    var dataSource: CollectionDataSource!
    
    var networkManager = NetworkManager()
    var subscriptions: Set<AnyCancellable> = []
    var flights: [Flight] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.title = "Popular flights"
    }
    
    private func configureCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        view.addSubview(collectionView)
    }
    
    private func configureDataSource(){
        let cellRegistration = UICollectionView.CellRegistration<FlightCollectionViewCell, Flight> { cell, indexPath, flight in
            var content =  cell.defaultCellConfiguration()
            
            content.cityTo = flight.cityTo
            content.departureDate = flight.departureDate
            content.price = flight.price
            content.backgroundImage = flight.image ?? ImageCache.placeholder
            
            ImageCache.publicCache.loadImage(from: .photos(imageId: flight.destinationID, resolution: .medium))
                .receive(on: DispatchQueue.main)
                .sink { (image) in
                    if image != flight.image {
                        var updatedSnapshot = self.dataSource.snapshot()
                        if let index = updatedSnapshot.indexOfItem(flight) {
                            let flight = self.flights[index]
                            flight.image = image
                            updatedSnapshot.reloadItems([flight])
                            self.dataSource.apply(updatedSnapshot, animatingDifferences: true)
                        }
                    }
                }.store(in: &self.subscriptions)
            
            cell.contentConfiguration = content
        }
        
        dataSource = CollectionDataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPath, flight) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: flight)
        })
        
        self.initialSnapshot()
    }
    
    private func initialSnapshot() {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        
        showActivityIndicator(view: view)
        networkManager.fetchFlights()
            .receive(on: DispatchQueue.main)
            .sink { (completion) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    //TODO alert error
                    print("Error: \(error)")
                }
            } receiveValue: { [unowned self] (flights) in
                self.flights = flights
                
                snapshot.appendItems(self.flights, toSection: .main)
                self.hideActivityIndicator()
                self.dataSource.apply(snapshot, animatingDifferences: true)
            }.store(in: &subscriptions)
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let itemHeight = CGFloat(160)
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(itemHeight))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(itemHeight))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 12
        section.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 15)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
}

extension ResultsViewController: UICollectionViewDelegate {
        //show detail
}
