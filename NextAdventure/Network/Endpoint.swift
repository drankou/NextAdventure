//
//  Endpoint.swift
//  NextAdventure
//
//  Created by Aliaksandr Drankou on 07.02.2021.
//

import Foundation

struct Endpoint {
    let path: String
    let queryItems: [URLQueryItem]
    
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.skypicker.com"
        components.path = path
        components.queryItems = [
            URLQueryItem(name: "v", value: "3"),
            URLQueryItem(name: "partner", value: "picky"),
            URLQueryItem(name: "locale", value: "en"),
            URLQueryItem(name: "currency", value: "EUR"),
        ]
        components.queryItems?.append(contentsOf: queryItems)
        
        return components.url!
    }
}

extension Endpoint {
    static func flights() -> Endpoint {
        return Endpoint(
            path: "/flights",
            queryItems: [
                URLQueryItem(name: "flyFrom", value: "BRQ"),
                URLQueryItem(name: "to", value: "anywhere"),
                URLQueryItem(name: "dateFrom", value: "01/04/2021"),
                URLQueryItem(name: "dateTo", value: "12/04/2021"),
                URLQueryItem(name: "sort", value: "popularity"),
                URLQueryItem(name: "asc", value: "0"),
                URLQueryItem(name: "adults", value: "1"),
                URLQueryItem(name: "featureName", value: "aggregateResults"),
                URLQueryItem(name: "limit", value: "10")
            ]
        )
    }
}
