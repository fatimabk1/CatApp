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
    
    init(catId: String) {
        viewModel = DetailViewModel(catId: catId)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
               Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
                    .border(.red)
                if let cat = viewModel.cat {
                    Text(cat.name)
                        .font(.title)
                    Text(cat.sex)
                    Text(viewModel.categories)
                    Text(cat.date)
                }
                if viewModel.catFetchError {
                    Text("\nUnable to fetch cat detail.")
                }
            }
            .padding()
        }
        .onAppear {
            viewModel.loadCatDetailOnAppear()
        }
    }
}

#Preview {
    DetailView(catId: "a233d4f2")
}
