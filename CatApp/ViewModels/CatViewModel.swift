//
//  CatViewModel.swift
//  CatApp
//
//  Created by Fatima Kahbi on 6/6/24.
//

import Foundation
import Combine


final class CatViewModel: ObservableObject {
    let twoColumns: Bool // TODO: should come from storage
    let networkService: NetworkManager
    var isLiked: Bool
    
    private var cancellables = Set<AnyCancellable>()
    
    init(twoColumns: Bool, networkService: NetworkManager, isLiked: Bool) {
        self.twoColumns = twoColumns
        self.networkService = networkService
        self.isLiked = isLiked
    }
    
    func like(catId: String, completion: @escaping (() -> Void)) {
        networkService.likeCat(catId: catId)
            .sink { completion in
                if case .failure(let error) = completion {
                    // TODO: DO SOMETHING?
                    print(error)
                    print("completion failure")
                }
            } receiveValue: { _ in
                completion()
            }
            .store(in: &cancellables)
    }
    
    func unlike(catId: String, completion: @escaping (() -> Void)) {
        networkService.unlikeCat(catId: catId)
            .sink { completion in
                if case .failure(_) = completion {
                    // TODO: DO SOMETHING?
                }
            } receiveValue: { _ in
                completion()
            }
            .store(in: &cancellables)
    }
    
}
