//
//  MockNetworkManager.swift
//  CatApp
//
//  Created by Fatima Kahbi on 5/25/24.
//

import Foundation
import Combine

enum NetworkError: Error {
    case noInternet
}

final class MockNetworkManager: NetworkManager {
    private let cats = Cat.sampleData
    private let banners = Banner.sampleData
    
    private let queue: DispatchQueue
    private var cancellables = Set<AnyCancellable>()
    
    init(queue: DispatchQueue = DispatchQueue.global()) {
        self.queue = queue
    }
    
    func fetchCats() -> AnyPublisher<[Cat], NetworkError> {
        return Future<[Cat], NetworkError> { promise in
            self.queue.async { [weak self] in
                guard let self else { return }
                promise(.success(cats))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func fetchBanners() -> AnyPublisher<[Banner], NetworkError> {
        return Future<[Banner], NetworkError> { promise in
            self.queue.async { [weak self] in
                guard let self else { return }
                promise(.success(banners))
            }
        }
        .eraseToAnyPublisher()
    }
    
//    func fetchImage(url: URL) -> AnyPublisher<
}
