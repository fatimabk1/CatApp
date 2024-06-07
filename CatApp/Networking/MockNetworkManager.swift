//
//  MockNetworkManager.swift
//  CatApp
//
//  Created by Fatima Kahbi on 5/25/24.
//

import Foundation
import Combine


final class MockNetworkManager: NetworkManager {
    private let cats: [Cat]
    private let banners: [Banner]
    private var userLikes: [Cat]
    
    private var cancellables = Set<AnyCancellable>()
    
    init(cats: [Cat] = Cat.sampleData, banners: [Banner] = Banner.sampleData, userLikes: [Cat] = []) {
        self.cats = cats
        self.banners = banners
        self.userLikes = userLikes
    }
    
    func fetchCats() -> AnyPublisher<[Cat], NetworkError> {
        return Just(cats)
            .setFailureType(to: NetworkError.self)
            .eraseToAnyPublisher()
    }
    
    func fetchBanners() -> AnyPublisher<[Banner], NetworkError> {
        return Just(banners)
            .setFailureType(to: NetworkError.self)
            .eraseToAnyPublisher()
    }
    
    func fetchCatDetail(catId: String) -> AnyPublisher<Cat, NetworkError> {
        if let cat = self.cats.first(where: {$0.id == catId}) {
            return Just(cat)
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
        }
        return Fail(error: .noInternet)
            .eraseToAnyPublisher()
    }
    
    func login() -> AnyPublisher<BearerToken, NetworkError> {
        let tokenString = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3MTc3NzQyMTQsInVzZXJuYW1lIjoidGVjaC1jaGFsbGVuZ2VAc2hvd3lvdXJjYXQuY29tIn0.Gcj2MLgIzTwBylkKFH3j85tIKiKAjOlxt92SeFssa28"
        let token = BearerToken(token: tokenString)
        
        return Just(token)
            .setFailureType(to: NetworkError.self)
            .eraseToAnyPublisher()
    }
    
    func likeCat(catId: String) -> AnyPublisher<Void, NetworkError> {
        let cat = cats.first(where: {$0.id == catId})
        if let cat {
            userLikes.append(cat)
            print(userLikes)
            return Just(())
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
        }
        
        return Fail(error: .invalidRequest)
            .eraseToAnyPublisher()
    }
    
    func unlikeCat(catId: String) -> AnyPublisher<Void, NetworkError> {
        let index = userLikes.firstIndex(where: {$0.id == catId})
        if let index {
            userLikes.remove(at: index)
            return Just(())
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
        }
        
        return Fail(error: .invalidRequest)
            .eraseToAnyPublisher()
    }
    
    func fetchUserLikes() -> AnyPublisher<[Cat], NetworkError> {
        return Just(cats)
            .setFailureType(to: NetworkError.self)
            .eraseToAnyPublisher()
    }
}
