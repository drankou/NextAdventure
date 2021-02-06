//
//  ViewController.swift
//  NextAdventure
//
//  Created by Aliaksandr Drankou on 06.02.2021.
//

import UIKit

class HomeViewController: UIViewController {
    weak var coordinator: AppCoordinator?

    override func loadView() {
        super.loadView()
        let view = HomeView(frame: UIScreen.main.bounds)        
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

