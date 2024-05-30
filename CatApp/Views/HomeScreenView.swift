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
                if viewModel.catFetchError {
                    Text("Error: Failed to load cats")
                }
                if viewModel.bannerFetchError {
                    Text("Error: Failed to load banners")
                }
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
    
    private var scrollableBanners: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack {
                ForEach(viewModel.banners, id: \.id) { banner in
                    BannerView(banner: banner)
                }
            }
            .padding()
        }
    }
    
    private var scrollableCategories: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack {
                ForEach(viewModel.categories, id: \.self) { category in
                    CategoryView(category: category, selectedCategory: $viewModel.selectedCategory)
                }
            }
            .padding()
        }
    }
    
    private var catCollection: some View {
        var columns: [GridItem] {
            if twoColumns {
                [GridItem(.flexible()), GridItem(.flexible())]
            } else {
                [GridItem(.flexible())]
            }
        }
        
        return VStack {
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
                        CatView(cat: cat)
                    }
                }
            }
            .padding()
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
