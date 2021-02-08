//
//  FlightDetailView.swift
//  NextAdventure
//
//  Created by Aliaksandr Drankou on 08.02.2021.
//

import UIKit

class FlightDetailView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let flightImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 50
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(containerStack)
        NSLayoutConstraint.activate([
            containerStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 25),
            containerStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            containerStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
        ])
        
        view.addSubview(bookButton)
        NSLayoutConstraint.activate([
            bookButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            bookButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        return view
    }()
    
    
    lazy var containerStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [routeStack])
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    lazy var routeStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [cityFromLabel, cityToLabel])
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        
        return stack
    }()

    let cityToLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 28, weight: .medium)
        
        return label
    }()
    
    
    let cityFromLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 28, weight: .medium)
        
        return label
    }()
    
    let bookButton: UIButton = {
        let button = AnimatedButton()
        button.layer.cornerRadius = 16
        button.backgroundColor = UIColor(red: 174/255, green: 185/255, blue: 103/255, alpha: 1.0)
        button.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 22)
        button.setTitle("Book", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(UIColor.systemGray, for: .highlighted)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        return button
    }()
    
    private func configure(){
        backgroundColor = .systemBackground
        addSubview(flightImageView)
        NSLayoutConstraint.activate([
            flightImageView.topAnchor.constraint(equalTo: self.topAnchor),
            flightImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            flightImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            flightImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.6),
        ])
        
        addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: flightImageView.bottomAnchor, constant: -50),
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}
