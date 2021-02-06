//
//  AnimatedButton.swift
//  NextAdventure
//
//  Created by Aliaksandr Drankou on 06.02.2021.
//

import UIKit

class AnimatedButton: UIButton {
    override var isHighlighted: Bool {
        didSet {
            let transform: CGAffineTransform = isHighlighted ? .init(scaleX: 0.95, y: 0.95) : .identity
            animate(transform)
        }
    }
}

private extension AnimatedButton {
    private func animate(_ transform: CGAffineTransform) {
        UIView.animate(
            withDuration: 0.4,
            delay: 0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 3,
            options: [.curveEaseInOut],
            animations: {
                self.transform = transform
            }
        )
    }
}
