//
//  Destination.swift
//  NextAdventure
//
//  Created by Aliaksandr Drankou on 06.02.2021.
//

import Foundation

struct Flight: Codable, Hashable {
    var id: String
    var departureTime: Int
    var arrivalTime: Int
    var flyDuration: String
    var flyFrom: String
    var cityFrom: String
    var flyTo: String
    var cityTo: String
    var price: Int
    //availability
    var deepLink: String //clear &amp; -> &
    
    private enum CodingKeys: String, CodingKey {
        case id
        case flyFrom
        case cityFrom
        case flyTo
        case cityTo
        case price
        
        case deepLink = "deep_link"
        case departureTime = "dTimeUTC"
        case arrivalTime = "aTimeUTC"
        case flyDuration = "fly_duration"
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Flight, rhs: Flight) -> Bool {
        lhs.id == rhs.id
    }
}

extension Flight {
    var departureDate: String? {
        return formatString(from: departureTime)
    }
    
    private func formatString(from timestamp: Int) -> String{
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E MMM d, yyyy"
        
        return dateFormatter.string(from: date)
    }
}

struct FlightsResponse: Codable, Hashable {
    var data: [Flight]
}
