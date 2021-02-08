//
//  HomeView.swift
//  NextAdventure
//
//  Created by Aliaksandr Drankou on 06.02.2021.
//

import UIKit

class HomeView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Your next adventure starts here"
        label.textColor = .white
        label.font = UIFont(name: "Sansation-Light", size: 48)
        label.textAlignment = .center
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let exploreButton: UIButton = {
        let button = AnimatedButton()
        button.layer.cornerRadius = 16
        button.backgroundColor = UIColor(red: 174/255, green: 185/255, blue: 103/255, alpha: 1.0)
        button.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 28)
        button.setTitle("Explore", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(UIColor.systemGray, for: .highlighted)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 50),
            button.widthAnchor.constraint(equalToConstant: 250)
        ])
        
        return button
    }()
    
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "homescreen.jpg")!)
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false

        let overlay = CALayer()
        overlay.frame = UIScreen.main.bounds
        overlay.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.15).cgColor;
        imageView.layer.insertSublayer(overlay, at: 0)
        
        return imageView
    }()

    private func configure(){
        self.addSubview(backgroundImageView)
        NSLayoutConstraint.activate([
            backgroundImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        
        backgroundImageView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: backgroundImageView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: backgroundImageView.trailingAnchor, constant: -10),
            titleLabel.centerXAnchor.constraint(equalTo: backgroundImageView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: backgroundImageView.centerYAnchor, constant: -100),
        ])

        backgroundImageView.addSubview(exploreButton)
        NSLayoutConstraint.activate([
            exploreButton.centerXAnchor.constraint(equalTo: backgroundImageView.centerXAnchor),
            exploreButton.bottomAnchor.constraint(equalTo: backgroundImageView.bottomAnchor, constant: -150),
        ])
    }
}
