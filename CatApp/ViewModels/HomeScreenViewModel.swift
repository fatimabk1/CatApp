//
//  HomeScreenViewModel.swift
//  CatApp
//
//  Created by Fatima Kahbi on 5/25/24.
//

import Foundation
import Combine

enum Status {
    case loading
    case loaded
    case empty
    case error
}


final class HomeScreenViewModel: ObservableObject {
    @Published var banners: [Banner] = []
    @Published var cats: [Cat] = []
    @Published var categories: [String] = []
    
    @Published var catStatus: Status = .loading
    @Published var bannerStatus: Status = .loading
    @Published var categoryStatus: Status = .loading
    
    @Published var selectedCategory = ""
    var filteredCats: [Cat] {
        if selectedCategory == "" {
            return cats
        }
        return cats.filter({$0.categories.contains(selectedCategory)})
    }
    
    let title = "Cats"
    
    private let endpointService = EndPointService()
    private let networkService = NetworkService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
    }
    
    func handleOnAppear() {
        fetchCats()
        fetchBanners()
    }
    
    private func fetchCats() {
        let catsUrl = endpointService.getURL(endpoint: .cats)
        switch catsUrl {
        case .success(let url):
            networkService.fetch(url: url)
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: { [weak self] completion in
                    if case .failure(_) = completion {
                        print("failed to complete - fetch cats")
                        print(completion)
                        self?.catStatus = .error
                    }
                }, receiveValue: { [weak self] (cats: [Cat]) in
                    guard let self else { return }
                    self.cats = cats
                    self.catStatus = cats.isEmpty ? .empty : .loaded
                    
                    let catCategories = cats.compactMap({$0.categories})
                    self.categories = Array(Set(catCategories.flatMap({$0})))
                    self.categoryStatus = categories.isEmpty ? .empty : .loaded
                })
                .store(in: &cancellables)
            
        case .failure(_):
            print("invalid URL")
            self.catStatus = .error
        }
    }
    
    private func fetchBanners() {
        let bannerURL = endpointService.getURL(endpoint: .banners)
        switch bannerURL {
        case .success(let url):
            networkService.fetch(url: url)
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: { [weak self] completion in
                    if case .failure(_) = completion {
                        self?.bannerStatus = .error
                    }
                }, receiveValue: { [weak self] (banners: [Banner]) in
                    self?.banners = banners
                    self?.bannerStatus = banners.isEmpty ? .empty : .loaded
                })
                .store(in: &cancellables)
        case .failure(_):
            self.bannerStatus = .error
        }
    }
    
}
