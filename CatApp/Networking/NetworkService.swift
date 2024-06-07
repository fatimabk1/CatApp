//
//  NetworkService.swift
//  CatApp
//
//  Created by Fatima Kahbi on 5/30/24.
//

import Foundation
import Combine


final class NetworkService: NetworkManager {
    private let cancellables = Set<AnyCancellable>()
    private let endpointService = EndPointService()
    private let requestService = RequestService()
    
    private func fetch<T: Decodable>(request: URLRequest) -> AnyPublisher<T, NetworkError> {
        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { result in
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                guard let urlResponse = result.response as? HTTPURLResponse, (200...299).contains(urlResponse.statusCode) else {
                    throw NetworkError.invalidResponse
                }
                
                do {
                    return try decoder.decode(T.self, from: result.data)
                } catch {
                    throw NetworkError.invalidData
                }
            }
            .mapError { error in
                if let networkError = error as? NetworkError {
                    return networkError
                } else {
                    return NetworkError.failedToComplete
                }
            }
            .retry(6)
            .eraseToAnyPublisher()
    }
    
    private func fetch(request: URLRequest) -> AnyPublisher<Void, NetworkError> {
        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { result in
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                guard let urlResponse = result.response as? HTTPURLResponse, (200...299).contains(urlResponse.statusCode) else {
                    throw NetworkError.invalidResponse
                }
            }
            .mapError { error in
                if let networkError = error as? NetworkError {
                    return networkError
                } else {
                    return NetworkError.failedToComplete
                }
            }
            .retry(6)
            .eraseToAnyPublisher()
    }
    
    func fetchCats() -> AnyPublisher<[Cat], NetworkError> {
        let urlResult = endpointService.getURL(endpoint: .cats)
        switch urlResult {
        case .success(let url):
            let result = requestService.configureRequest(url: url, endpoint: .cats)
            
            switch result {
            case .success(let request):
                return fetch(request: request)
            case .failure(_):
                return Fail(error: NetworkError.invalidRequest)
                    .eraseToAnyPublisher()
            }
            
        case .failure(_):
            return Fail(error: NetworkError.badURL)
                .eraseToAnyPublisher()
        }
    }
    
    func fetchBanners() -> AnyPublisher<[Banner], NetworkError> {
        let urlResult = endpointService.getURL(endpoint: .banners)
        switch urlResult {
        case .success(let url):
            let result = requestService.configureRequest(url: url, endpoint: .banners)
            
            switch result {
            case .success(let request):
                return fetch(request: request)
            case .failure(_):
                return Fail(error: NetworkError.invalidRequest)
                    .eraseToAnyPublisher()
            }
            
        case .failure(_):
            return Fail(error: NetworkError.badURL)
                .eraseToAnyPublisher()
        }
    }
    
    func fetchCatDetail(catId: String) -> AnyPublisher<Cat, NetworkError> {
        let urlResult = endpointService.getURL(endpoint: .specificCat(catId))
        switch urlResult {
        case .success(let url):
            let result = requestService.configureRequest(url: url, endpoint: .specificCat(catId))
            
            switch result {
            case .success(let request):
                return fetch(request: request)
            case .failure(_):
                return Fail(error: NetworkError.invalidRequest)
                    .eraseToAnyPublisher()
            }
            
        case .failure(_):
            return Fail(error: NetworkError.badURL)
                .eraseToAnyPublisher()
        }
    }
    
    func login() -> AnyPublisher<BearerToken, NetworkError> {
        let urlResult = endpointService.getURL(endpoint: .login)
        switch urlResult {
        case .success(let url):
            let result = requestService.configureRequest(url: url, endpoint: .login)
            
            switch result {
            case .success(let request):
                return fetch(request: request)
            case .failure(_):
                return Fail(error: NetworkError.invalidRequest)
                    .eraseToAnyPublisher()
            }
            
        case .failure(_):
            return Fail(error: NetworkError.badURL)
                .eraseToAnyPublisher()
        }
    }
    
    func likeCat(catId: String) -> AnyPublisher<Void, NetworkError> {
        let urlResult = endpointService.getURL(endpoint: .like(catId))
        switch urlResult {
        case .success(let url):
            let result = requestService.configureRequest(url: url, endpoint: .like(catId))
            
            switch result {
            case .success(let request):
                return fetch(request: request)
            case .failure(_):
                return Fail(error: NetworkError.invalidRequest)
                    .eraseToAnyPublisher()
            }
            
        case .failure(_):
            return Fail(error: NetworkError.badURL)
                .eraseToAnyPublisher()
        }
    }
    
    func unlikeCat(catId: String) -> AnyPublisher<Void, NetworkError> {
        let urlResult = endpointService.getURL(endpoint: .unlike(catId))
        switch urlResult {
        case .success(let url):
            let result = requestService.configureRequest(url: url, endpoint: .unlike(catId))
            
            switch result {
            case .success(let request):
                return fetch(request: request)
            case .failure(_):
                return Fail(error: NetworkError.invalidRequest)
                    .eraseToAnyPublisher()
            }
        case .failure(_):
            return Fail(error: NetworkError.badURL)
                .eraseToAnyPublisher()
        }
    }
    
    func fetchUserLikes() -> AnyPublisher<[Cat], NetworkError> {
        let urlResult = endpointService.getURL(endpoint: .userLikes)
        switch urlResult {
        case .success(let url):
            let result = requestService.configureRequest(url: url, endpoint: .userLikes)
            
            switch result {
            case .success(let request):
                return fetch(request: request)
            case .failure(_):
                return Fail(error: NetworkError.invalidRequest)
                    .eraseToAnyPublisher()
            }
        case .failure(_):
            return Fail(error: NetworkError.badURL)
                .eraseToAnyPublisher()
        }
    }
}
