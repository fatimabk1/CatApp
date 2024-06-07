//
//  HomeScreenView.swift
//  CatApp
//
//  Created by Fatima Kahbi on 5/25/24.
//

import SwiftUI


struct HomeScreenView: View {
    @ObservedObject var viewModel: HomeScreenViewModel
    @ObservedObject var profileViewModel: ProfileViewModel
    
    init(networkService: NetworkManager) {
        self.viewModel = HomeScreenViewModel(networkService: networkService)
        self.profileViewModel = ProfileViewModel(networkService: networkService)
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
                        ProfileView(viewModel: profileViewModel)
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
            BannerPlaceholder() // TODO: update w/error view
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
            CategoryPlaceholder() // TODO: update w/error view
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
            EmptyView()
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
                            CatView(cat: cat, twoColumns: viewModel.twoColumns, isLoggedIn: profileViewModel.isLoggedIn, networkService: viewModel.networkService , isLiked: viewModel.userLikes.contains(cat.id))
                            {
                                viewModel.onCatLikeUnlike()
                            }
                        }
                    }
                }
                .padding()
            }
        case .error:
            CatPlaceholder() // TODO: update w/error view
        }
    }
}


#Preview {
    HomeScreenView(networkService: NetworkService())
}

 
/*
 POA
 - profile screen w/disabled login button
 */
