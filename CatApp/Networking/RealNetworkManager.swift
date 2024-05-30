//
//  RealNetworkManager.swift
//  CatApp
//
//  Created by Fatima Kahbi on 5/30/24.
//

import Foundation
import Combine

struct APIError: Decodable, Error {
    let errorCode: Int
    let message: String

    enum CodingKeys: String, CodingKey {
        case errorCode = "code"
        case message
    }
}

enum EndPoints {
    case banners
    case cats
    case specificCat
}

enum EndPointError: Error {
    case invalidURL
}


final class EndPointService {
    private let baseUrl             = "https://show-your-cat.onrender.com"
    private let endpointBanners     = "/banner"
    private let endpointCats        = "/cats/"
    private let endpointSpecificCat = "/cat/"
    //    private let endpointLogin       = "/auth/login"
    //    private let endpointLike        = "/like"           // endpoint: /cats/<cat_id>/like
    //    private let endpointUnlike      = "/unlike"           // endpoint: /cats/<cat_id>/unlike
    //    private let endpointUserLikes   = "/user/likes"
    
    func getURL(endpoint: EndPoints, parameter: String? = nil) -> Result<URL, EndPointError> {
        var urlString = ""
        
        switch endpoint {
        case .banners:
            urlString = baseUrl + endpointBanners
        case .cats:
            urlString = baseUrl + endpointCats
        case .specificCat:
            if let parameter {
                urlString = baseUrl + endpointSpecificCat + parameter
            }
        }
        
        guard let url = URL(string: urlString) else {
            return .failure(.invalidURL)
        }
        return .success(url)
    }
}

final class NetworkService {
    private let cancellables = Set<AnyCancellable>()
    
    func fetch<T: Decodable>(url: URL) -> AnyPublisher<T, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { result in
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                guard let urlResponse = result.response as? HTTPURLResponse, (200...299).contains(urlResponse.statusCode) else {
                    let error = try decoder.decode(APIError.self, from: result.data)
                    throw error
                }
                return try decoder.decode(T.self, from: result.data)
            }
            .eraseToAnyPublisher()
    }
    
}
