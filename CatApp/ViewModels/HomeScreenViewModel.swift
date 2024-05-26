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
    
    let title = "Cat Tree"
    
    private let networkManager: NetworkManager
    private var cancellables = Set<AnyCancellable>()
    
    init(networkManager: NetworkManager = MockNetworkManager()) {
        self.networkManager = networkManager
        calculateCategories()
    }
    
    func calculateCategories() {
        // TODO: START HERE
        /*
         - calculate categories with map / flat map
         - buid UI & test
         - look into combine for networking, retrying, handling errors, refresh on swipe down
         */
        $cats
            .sink { cats in
                var categorySet = Set<String>()
//                let catCategories = cats.compactMap(Cat.)
            }
            .store(in: &cancellables)
    }
    
    func handleOnAppear() {
        networkManager.fetchCats()
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure(_) = completion {
                    self?.catFetchError = true
                }
            }, receiveValue: { [weak self] cats in
                self?.cats = cats
            })
            .store(in: &cancellables)
        

        networkManager.fetchBanners()
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure(_) = completion {
                    self?.bannerFetchError = true
                }
            }, receiveValue: { [weak self] banners in
                self?.banners = banners
            })
            .store(in: &cancellables)
    }
    
}
