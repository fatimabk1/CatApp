//
//  HomeScreenViewModel.swift
//  CatApp
//
//  Created by Fatima Kahbi on 5/25/24.
//

import Foundation
import Combine


final class HomeScreenViewModel: ObservableObject {
    @Published var banners: [Banner] = []
    @Published var cats: [Cat] = []
    @Published var categories: [String] = []
    
    @Published var catFetchError: Bool = false
    @Published var bannerFetchError: Bool = false
    
    @Published var selectedCategory: String? = nil
    var filteredCats: [Cat] {
        if let selectedCategory {
            if selectedCategory == "" {
                return cats
            }
            return cats.filter({$0.categories.contains(selectedCategory)})
        }
        return cats
    }
    
    let title = "Cat Tree"
    
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
                        print("failed to complete")
                        print(completion)
                        self?.catFetchError = true
                    }
                }, receiveValue: { [weak self] (cats: [Cat]) in
                    guard let self else { return }
                    self.cats = cats
                    let catCategories = cats.compactMap({$0.categories})
                    self.categories = Array(Set(catCategories.flatMap({$0})))
                })
                .store(in: &cancellables)
            
        case .failure(_):
            print("invalid URL")
            self.catFetchError = true
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
                        self?.bannerFetchError = true
                    }
                }, receiveValue: { [weak self] (banners: [Banner]) in
                    self?.banners = banners
                })
                .store(in: &cancellables)
        case .failure(_):
            self.bannerFetchError = true
        }
    }
    
}
