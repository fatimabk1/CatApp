//
//  HomeScreenViewModel.swift
//  CatApp
//
//  Created by Fatima Kahbi on 5/25/24.
//

import Foundation
import Combine


final class HomeScreenViewModel: ObservableObject {
    @Published var isLoggedIn: Bool = false
    
    @Published var banners: [Banner] = []
    @Published var cats: [Cat] = []
    @Published var categories: [String] = []
    @Published var userLikes = Set<String>()
    
    @Published var catStatus: LoadStatus = .loading
    @Published var bannerStatus: LoadStatus = .loading
    @Published var categoryStatus: LoadStatus = .loading
    
    @Published var twoColumnsCache: Bool
    var twoColumns: Bool {
        get {
            return twoColumnsCache
        }
        set {
            twoColumnsCache = newValue
            UserDefaults.standard.set(twoColumnsCache, forKey: "twoColumns")
        }
    }
    
    @Published var selectedCategory = ""
    var filteredCats: [Cat] {
        if selectedCategory == "" {
            return cats
        }
        return cats.filter({$0.categories.contains(selectedCategory)})
    }
    
    let title = "Cats"
    let networkService: NetworkManager
    let profileService: ProfileService
    private let keychain = KeychainAccess.standard
    private var cancellables = Set<AnyCancellable>()
    
    init(networkService: NetworkManager = NetworkService(), profileService: ProfileService) {
        self.networkService = networkService
        self.twoColumnsCache = UserDefaults.standard.bool(forKey: "twoColumns")
        self.profileService = profileService
    }
    
    func handleOnAppear() {
        fetchCats()
        fetchBanners()
        fetchUserLikes()
        setupProfileServiceSubscriptions()
    }
    
    private func setupProfileServiceSubscriptions() {
        profileService.isLoggedIn
            .sink { [weak self] isLoggedIn in
                self?.isLoggedIn = isLoggedIn
                if !isLoggedIn {
                    self?.userLikes = []
                } else {
                    self?.fetchUserLikes()
                }
            }
            .store(in: &cancellables)
    }
    
    func onCatLikeUnlike(catId: String) {
        if isLoggedIn {
            fetchUserLikes()
            reloadCatItem(catId: catId)
        }
    }
    
    private func reloadCatItem(catId: String) {
        networkService.fetchCatDetail(catId: catId)
            .receive(on: RunLoop.main)
            .sink { completion in
                if  case .failure(_) = completion {
                    print("Error reloading cat item")
                }
            } receiveValue: { [weak self] cat in
                if let index = self?.cats.firstIndex(where: {$0.id == cat.id}) {
                    self?.cats[index] = cat
                }
            }
            .store(in: &cancellables)
    }
    
    private func fetchUserLikes() {
        networkService.fetchUserLikes()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                if case .failure(_) = completion {
                    //TODO: ERROR HANDLING
                }
            }, receiveValue: { [weak self] (cats: [Cat]) in
                self?.userLikes = Set(cats.map({$0.id}))
            })
            .store(in: &cancellables)
    }
    
    private func fetchCats() {
        networkService.fetchCats()
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
    }
    
    private func fetchBanners() {
        networkService.fetchBanners()
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
    }
    
}
