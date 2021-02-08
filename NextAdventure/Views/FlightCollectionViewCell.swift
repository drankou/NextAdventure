//
//  FlightCollectionViewCell.swift
//  NextAdventure
//
//  Created by Aliaksandr Drankou on 06.02.2021.
//

import UIKit

class FlightCollectionViewCell: UICollectionViewCell {
    public func defaultCellConfiguration() -> FlightCellContentConfiguration {
        return FlightCellContentConfiguration()
    }
}

struct FlightCellContentConfiguration: UIContentConfiguration, Hashable {
    var backgroundImage: UIImage?
    var cityTo: String?
    var departureDate: String?
    var price: Int?
    
    func makeContentView() -> UIView & UIContentView {
        return FlightCellContentView(configuration: self)
    }
    
    func updated(for state: UIConfigurationState) -> Self {
        return self
    }
}

class FlightCellContentView: UIView, UIContentView {
   
    private var appliedConfiguration: FlightCellContentConfiguration!
    var configuration: UIContentConfiguration {
        get { appliedConfiguration }
        set {
            guard let newConfig = newValue as? FlightCellContentConfiguration else { return }
            apply(configuration: newConfig)
            updateGradientFrame()
        }
    }
    
    init(configuration: FlightCellContentConfiguration) {
        super.init(frame: .zero)
        configure()
        apply(configuration: configuration)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func apply(configuration: FlightCellContentConfiguration) {
        guard appliedConfiguration != configuration else { return }
        appliedConfiguration = configuration

        destinationLabel.text = configuration.cityTo
        dateLabel.text = configuration.departureDate
        priceLabel.text = "\(configuration.price!) €"
        backgroundImageView.image = configuration.backgroundImage
    }
    
    private func configure(){
        self.addSubview(backgroundImageView)
        self.layer.cornerRadius = 16
        self.layer.masksToBounds = true
        //todo shadow

        NSLayoutConstraint.activate([
            backgroundImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        
        backgroundImageView.addSubview(containerStack)
        NSLayoutConstraint.activate([
            containerStack.widthAnchor.constraint(equalTo: backgroundImageView.widthAnchor),
            containerStack.leadingAnchor.constraint(equalTo: backgroundImageView.leadingAnchor),
            containerStack.trailingAnchor.constraint(equalTo: backgroundImageView.trailingAnchor),
            containerStack.bottomAnchor.constraint(equalTo: backgroundImageView.bottomAnchor),
        ])
    }
    
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    let gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.7)
        gradientLayer.colors = [UIColor.white.withAlphaComponent(0.0).cgColor, UIColor.black.withAlphaComponent(0.5).cgColor]
        
        return gradientLayer
    }()
    
    func updateGradientFrame() {
        gradientLayer.frame = backgroundImageView.bounds
        backgroundImageView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    let destinationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 28, weight: .medium)
        
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        
        return label
    }()
    
    
    private lazy var descriptionStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [destinationLabel, dateLabel])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.alignment = .fill
        
        return stack
    }()
    
    private lazy var containerStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [descriptionStack, priceLabel])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: 0, left: 15, bottom: 8, right: 15)
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
}
