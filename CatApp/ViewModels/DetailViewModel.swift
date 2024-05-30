//
//  DetailViewModel.swift
//  CatApp
//
//  Created by Fatima Kahbi on 5/30/24.
//

import Foundation
import Combine


final class DetailViewModel: ObservableObject {
    let catId: String
    
    @Published var cat: Cat? = nil
    @Published var catFetchError = false
    var categories: String {
        cat?.categories.joined(separator: ", ") ?? ""
    }
    
    private let endpointService = EndPointService()
    private let networkService = NetworkService()
    private var cancellables = Set<AnyCancellable>()
    
    init(catId: String) {
        self.catId = catId
    }
    
    func loadCatDetailOnAppear() {
        let catDetailURL = endpointService.getURL(endpoint: .specificCat, parameter: catId)
        switch catDetailURL {
        case .success(let url):
            networkService.fetch(url: url)
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: { [weak self] completion in
                    if case .failure(_) = completion {
                        print("failed to complete")
                        print(completion)
                        self?.catFetchError = true
                    }
                }, receiveValue: { [weak self] (cat: Cat) in
                    guard let self else { return }
                    self.cat = cat
                })
                .store(in: &cancellables)
            
        case .failure(_):
            print("invalid URL")
            self.catFetchError = true
        }
    }

}
