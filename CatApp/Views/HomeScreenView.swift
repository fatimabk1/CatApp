//
//  HomeScreenView.swift
//  CatApp
//
//  Created by Fatima Kahbi on 5/25/24.
//

import SwiftUI


struct HomeScreenView: View {
    @ObservedObject var viewModel = HomeScreenViewModel()
    @State var twoColumns = true
    
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
                        BannerView(banner: banner)
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
            if twoColumns {
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
                    twoColumns.toggle()
                } label: {
                    Image(systemName: twoColumns ? "rectangle.grid.2x2" : "rectangle.grid.1x2")
                }
                .padding(.trailing)
                .frame(maxWidth: .infinity, alignment: .trailing)
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(viewModel.filteredCats, id: \.id) { cat in
                            CatView(cat: cat, twoColumns: twoColumns)
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
    HomeScreenView()
}

 
/*
 POA
 - profile screen w/disabled login button
 - look into combine for networking, retrying, handling errors, refresh on swipe down
 */
