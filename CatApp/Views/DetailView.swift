//
//  DetailView.swift
//  CatApp
//
//  Created by Fatima Kahbi on 5/25/24.
//

import Foundation
import SwiftUI


struct DetailView: View {
    @ObservedObject var viewModel: DetailViewModel
    
    init(catId: String, networkService: NetworkManager) {
        viewModel = DetailViewModel(catId: catId, networkService: networkService)
    }
    
    var body: some View {
        VStack {
            Text(viewModel.cat?.name ?? "")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top)
            ScrollView {
                VStack(alignment: .leading) {
                    if viewModel.catDetailStatus == .loading {
                        VStack {
                            Image(systemName: "rectangle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .redacted(reason: .placeholder)
                            detailPlaceholder
                        }
                    } else if viewModel.catDetailStatus == .loaded {
                        RemoteImage(picture: viewModel.picture, width: .infinity, height: 400)
                        if let cat = viewModel.cat {
                            Text(cat.sex.capitalized)
                                .font(.title)
                                .padding()
                            Text(viewModel.categories.capitalized)
                                .font(.title)
                                .padding()
                            Text(cat.date)
                                .font(.title)
                                .padding()
                        }
                    } else if viewModel.catDetailStatus == .error {
                        VStack {
                            Text("Oops! Unable to load cat detail.")
                                .font(.title)
                                .padding()
                            Spacer()
    
                        }
                    }
                }
                .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.loadCatDetailOnAppear()
        }
    }
    
    private var detailPlaceholder: some View {
        VStack {
            Text("Mittens")
                .font(.title)
                .redacted(reason: .placeholder)
            Text("Male")
                .redacted(reason: .placeholder)
            Text("Cute, Cuddly, Shy")
                .redacted(reason: .placeholder)
            Text("Today's Date")
                .redacted(reason: .placeholder)
        }
    }
}

#Preview {
    DetailView(catId: "a233d4f2", networkService: NetworkService())
}
