//
//  NetworkManager.swift
//  NextAdventure
//
//  Created by Aliaksandr Drankou on 06.02.2021.
//

import Foundation
import UIKit
import Combine

enum NetworkError: Error {
  case statusCode
  case decoding
  case invalidImage
  case invalidURL
  case other(Error)
  
  static func map(_ error: Error) -> NetworkError {
    return (error as? NetworkError) ?? .other(error)
  }
}

class NetworkManager {
    func fetchFlights() -> AnyPublisher<[Flight], NetworkError> {
        return fetch(from: .flights(), of: FlightsResponse.self)
            .map { (response) -> [Flight] in
                response.data
            }
            .eraseToAnyPublisher()
    }
    
    func fetch<T:Decodable>(from endpoint: Endpoint, of type: T.Type) -> AnyPublisher<T, NetworkError> {
        return URLSession.shared.dataTaskPublisher(for: endpoint.url)
            .tryMap { response in
                guard let httpURLResponse = response.response as? HTTPURLResponse, httpURLResponse.statusCode == 200 else {
                    throw NetworkError.statusCode
                }

                return response.data
              }
              .decode(type: T.self, decoder: JSONDecoder())
              .mapError { NetworkError.map($0) }
              .eraseToAnyPublisher()
    }
    
    
    static func downloadImage(url: String) -> AnyPublisher<UIImage, NetworkError> {
      guard let url = URL(string: url) else {
        return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
      }

      return URLSession.shared.dataTaskPublisher(for: url)
        .tryMap { response -> Data in
          guard let httpURLResponse = response.response as? HTTPURLResponse, httpURLResponse.statusCode == 200 else {
              throw NetworkError.statusCode
          }
          
          return response.data
        }
        .tryMap { data in
          guard let image = UIImage(data: data) else {
            throw NetworkError.invalidImage
          }
            
          return image
        }
        .mapError { NetworkError.map($0) }
        .eraseToAnyPublisher()
    }
}
