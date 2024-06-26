//
//  HomeScreenView.swift
//  CatApp
//
//  Created by Fatima Kahbi on 5/25/24.
//

import SwiftUI


struct HomeScreenView: View {
    @ObservedObject var viewModel: HomeScreenViewModel
    
    init(networkService: NetworkManager) {
        self.viewModel = HomeScreenViewModel(networkService: networkService, profileService: ProfileService(networkService: networkService))
    }
    
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack {
                    scrollableBanners
                    scrollableCategories
                    catCollection
                }
            }
            .navigationTitle("Cat Tree")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        ProfileView(profileService: viewModel.profileService, loginStatus: viewModel.loginStatus, isLoggedIn: viewModel.isLoggedIn)
                    } label: {
                        VStack {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .frame(width: 25, height: 25)
                            Text("Profile")
                        }
                    }
                }
            }
        }
        .onAppear {
            viewModel.handleOnAppear()
        }
    }
    
    @ViewBuilder
    private var scrollableBanners: some View {
        switch viewModel.bannerStatus {
        case .empty:
            EmptyView()
        case .loading:
            ScrollView(.horizontal, showsIndicators: false){
                HStack {
                    ForEach(0..<2) { _ in
                        BannerPlaceholder()
                    }
                }
                .padding()
            }
        case .loaded:
            ScrollView(.horizontal, showsIndicators: false){
                HStack {
                    ForEach(viewModel.banners, id: \.id) { banner in
                        BannerView(banner: banner, networkService: viewModel.networkService)
                    }
                }
                .padding()
            }
        case .error:
            EmptyView()
        }
    }
    
    @ViewBuilder
    private var scrollableCategories: some View {
        switch viewModel.categoryStatus {
        case .empty:
            EmptyView()
        case .loading:
            ScrollView(.horizontal, showsIndicators: false){
                HStack {
                    ForEach(0..<5) { _ in
                        CategoryPlaceholder()
                    }
                }
                .padding()
            }
        case .loaded:
            ScrollView(.horizontal, showsIndicators: false){
                HStack {
                    ForEach(viewModel.categories, id: \.self) { category in
                        CategoryView(category: category, selectedCategory: $viewModel.selectedCategory)
                    }
                }
                .padding()
            }
        case .error:
            EmptyView()
        }
    }
    
    @ViewBuilder
    private var catCollection: some View {
        var columns: [GridItem] {
            if viewModel.twoColumns {
                [GridItem(.flexible()), GridItem(.flexible())]
            } else {
                [GridItem(.flexible())]
            }
        }
        
        
        switch viewModel.catStatus {
        case .empty:
            Text("No cats now - check back later!")
                .font(.title)
                .fontWeight(.bold)
        case .loading:
            LazyVGrid(columns: columns) {
                ForEach(0..<4) { _ in
                    CatPlaceholder()
                }
            }
            .padding()
        case .loaded:
            VStack {
                Button {
                    viewModel.twoColumns.toggle()
                } label: {
                    Image(systemName: viewModel.twoColumns ? "rectangle.grid.2x2" : "rectangle.grid.1x2")
                }
                .padding(.trailing)
                .frame(maxWidth: .infinity, alignment: .trailing)
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(viewModel.filteredCats, id: \.id) { cat in
                            CatView(cat: cat, twoColumns: viewModel.twoColumns, isLoggedIn: viewModel.isLoggedIn, networkService: viewModel.networkService , isLiked: viewModel.userLikes.contains(cat.id))
                            {
                                viewModel.onCatLikeUnlike(catId: cat.id)
                            }
                        }
                    }
                }
                .padding()
            }
        case .error:
            EmptyView()
        }
    }
}


#Preview {
    HomeScreenView(networkService: NetworkService())
}
