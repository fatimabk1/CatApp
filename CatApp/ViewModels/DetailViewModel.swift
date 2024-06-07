//
//  DetailViewModel.swift
//  CatApp
//
//  Created by Fatima Kahbi on 5/30/24.
//

import Foundation
import Combine


final class DetailViewModel: ObservableObject {
    @Published var cat: Cat? = nil
    @Published var catDetailStatus: LoadStatus = .loading
    
    let catId: String
    let networkService: NetworkManager
    
    var categories: String {
        cat?.categories.joined(separator: ", ") ?? ""
    }
    
    var picture: String {
        cat?.picture ?? ""
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    init(catId: String, networkService: NetworkManager) {
        self.catId = catId
        self.networkService = networkService
    }
    
    func loadCatDetailOnAppear() {
        networkService.fetchCatDetail(catId: catId)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure(_) = completion {
                    print("failed to complete - fetch cat detail")
                    self?.catDetailStatus = .error
                }
            }, receiveValue: { [weak self] (cat: Cat) in
                guard let self else { return }
                self.cat = cat
                self.catDetailStatus = .loaded
            })
            .store(in: &cancellables)
    }
}
