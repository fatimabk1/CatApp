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
}
