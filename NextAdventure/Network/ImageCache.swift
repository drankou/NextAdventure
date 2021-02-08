//
//  ImageCache.swift
//  NextAdventure
//
//  Created by Aliaksandr Drankou on 08.02.2021.
//

import Foundation
import UIKit
import Combine

final class ImageCache {
    static let publicCache = ImageCache()
    static let placeholder = UIImage(named: "placeholder")!
    private let cache = NSCache<NSURL, UIImage>()

    func loadImage(from url: URL) -> AnyPublisher<UIImage?, Never> {
        if let image = cache.object(forKey: url as NSURL){
            return Just(image).eraseToAnyPublisher()
        }
                
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { (data, response) -> UIImage? in return UIImage(data: data) }
            .catch { error in return Just(nil) }
            .handleEvents(receiveOutput: {[unowned self] image in
                guard let image = image else { return }
                self.cache.setObject(image, forKey: url as NSURL)
            })
            .subscribe(on: DispatchQueue.global())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
