//
//  NetworkService.swift
//  CatApp
//
//  Created by Fatima Kahbi on 5/30/24.
//

import Foundation
import Combine


final class NetworkService {
    private let cancellables = Set<AnyCancellable>()
    
    func fetch<T: Decodable>(url: URL) -> AnyPublisher<T, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { result in
//                if let dataString = String(data: result.data, encoding: .utf8) {
//                    print("Data as String:", dataString)
//                }
                
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                guard let urlResponse = result.response as? HTTPURLResponse, (200...299).contains(urlResponse.statusCode) else {
                    let error = try decoder.decode(APIError.self, from: result.data)
                    throw error
                }
                
                return try decoder.decode(T.self, from: result.data)
            }
            .retry(3)
            .eraseToAnyPublisher()
    }
    
}
