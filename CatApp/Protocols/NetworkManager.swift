//
//  NetworkManager.swift
//  CatApp
//
//  Created by Fatima Kahbi on 5/25/24.
//

import Foundation
import Combine

protocol NetworkManager {
    func fetchCats() -> AnyPublisher<[Cat], NetworkError>
    func fetchBanners() -> AnyPublisher<[Banner], NetworkError>
    func fetchCatDetail(catId: String) -> AnyPublisher<Cat, NetworkError>
    func login() -> AnyPublisher<BearerToken, NetworkError>
    func likeCat(catId: String) -> AnyPublisher<Void, NetworkError>
    func unlikeCat(catId: String) -> AnyPublisher<Void, NetworkError> 
    func fetchUserLikes() -> AnyPublisher<[Cat], NetworkError>
}

/*
 TODO: NEXT STEPS
 - Integrate login, like, unlike & test UI
 - Get local storage for userInfo and twoColumns Preference
 - Integrate login, like, unlike with NetworkService
 - Image caching
 */
