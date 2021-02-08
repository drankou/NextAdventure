//
//  ImagesEndpoint.swift
//  NextAdventure
//
//  Created by Aliaksandr Drankou on 08.02.2021.
//

import Foundation

enum ImageResolution: String {
    case low = "60x60"
    case medium = "610x251"
    case high = "1280x720"
}

enum ImageType: String {
    case airlines = "/airlines"
    case whitelabels = "/whitelabels"
    case photos = "/photos"
}


struct ImagesEndpoint {
    let imageId: String
    let imageType: ImageType
    let resolution: ImageResolution
    
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "images.kiwi.com"
        components.path = "\(imageType.rawValue)/\(resolution.rawValue)/\(imageId).jpg"
        
        return components.url!
    }
}

extension ImagesEndpoint {
    static func photos(imageId: String, resolution: ImageResolution) -> ImagesEndpoint {
        return ImagesEndpoint(
            imageId: imageId,
            imageType: .photos,
            resolution: resolution
        )
    }
}
