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
                        Image(systemName: "rectangle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .redacted(reason: .placeholder)
                    } else if viewModel.catDetailStatus == .loaded {
                        RemoteImage(picture: viewModel.picture, width: .infinity, height: 400)
                    }
                    
                    if let cat = viewModel.cat {
                        Text(cat.sex)
                        Text(viewModel.categories)
                        Text(cat.date)
                    } else {
                        detailPlaceholder
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
//    DetailView(catId: "ad4f2", networkService: NetworkService())
        // TODO: ADD display for Error

}
