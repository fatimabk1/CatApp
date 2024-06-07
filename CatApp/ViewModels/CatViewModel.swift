//
//  CatViewModel.swift
//  CatApp
//
//  Created by Fatima Kahbi on 6/6/24.
//

import Foundation
import Combine


final class CatViewModel: ObservableObject {
    let twoColumns: Bool
    let networkService: NetworkManager
    var isLiked: Bool
    let onLikeUnlike: () -> Void
    let isLoggedIn: Bool
    
    private var cancellables = Set<AnyCancellable>()
    
    init(twoColumns: Bool, networkService: NetworkManager, isLiked: Bool, onLikeUnlike: @escaping () -> Void, isLoggedIn: Bool, cancellables: Set<AnyCancellable> = Set<AnyCancellable>()) {
        self.twoColumns = twoColumns
        self.networkService = networkService
        self.isLiked = isLiked
        self.onLikeUnlike = onLikeUnlike
        self.isLoggedIn = isLoggedIn
        self.cancellables = cancellables
    }
    
    func like(catId: String, completion: @escaping (() -> Void)) {
        networkService.likeCat(catId: catId)
            .sink { completion in
                if case .failure(let error) = completion {
                    print(error)
                }
            } receiveValue: { _ in
                completion()
            }
            .store(in: &cancellables)
    }
    
    func unlike(catId: String, completion: @escaping (() -> Void)) {
        networkService.unlikeCat(catId: catId)
            .sink { completion in
                if case .failure(let error) = completion {
                    print(error)
                }
            } receiveValue: { _ in
                completion()
            }
            .store(in: &cancellables)
    }
    
}
