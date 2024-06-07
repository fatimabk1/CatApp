//
//  CatView.swift
//  CatApp
//
//  Created by Fatima Kahbi on 5/30/24.
//

import SwiftUI




struct CatView:  View {
    let viewModel: CatViewModel
    
    let cat: Cat
    let onLikeUnlike: () -> Void
    let isLoggedIn: Bool
    var categories: String {
        cat.categories.joined(separator: ", ").capitalized
    }

    init(cat: Cat, twoColumns: Bool, isLoggedIn: Bool, networkService: NetworkManager, isLiked: Bool, onLikeUnlike: @escaping () -> Void) {
        self.cat = cat
        self.isLoggedIn = isLoggedIn
        viewModel = CatViewModel(twoColumns: twoColumns, networkService: networkService, isLiked: isLiked)
        self.onLikeUnlike = onLikeUnlike
    }
    
    var body: some View {
        NavigationLink {
            DetailView(catId: cat.id, networkService: viewModel.networkService)
        } label: {
            VStack(alignment: .leading) {
                RemoteImage(picture: cat.picture, height: viewModel.twoColumns ? 200 : 400)
                HStack {
                    Text(cat.name)
                        .font(.title3)
                        .fontWeight(.bold)
                    Spacer()
                    Text("\(cat.likes)")
                    likeButton
                }
                .padding(.bottom, 5)
                sexAndCategories
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .foregroundStyle(.pink)
            )
        }
        .buttonStyle(.plain)
        .frame(maxHeight: .infinity)
    }
    
    private var likeButton: some View {
        Button {
            if isLoggedIn {
                if viewModel.isLiked {
                    viewModel.unlike(catId: cat.id) {
                        onLikeUnlike()
                    }
                } else {
                    viewModel.like(catId: cat.id) {
                        onLikeUnlike()
                    }
                }
            }
        } label: {
            Image(systemName: viewModel.isLiked ? "heart.fill" : "heart")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 25)
        }

    }
    
    private var sexAndCategories: some View {
        Group {
            HStack {
                Text("Sex: ")
                    .fontWeight(.semibold)
                Text(cat.sex.capitalized)
            }
            .padding(.bottom, 10)
            Text("Categories: ")
                .fontWeight(.semibold)
            Text(categories)
            Spacer()
        }
    }
}

#Preview {
    var columns: [GridItem] {
        [GridItem(spacing: 10),
//         GridItem(spacing: 10)
        ]
    }
    
    return Group {
        VStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(Cat.sampleData, id: \.id) { cat in
                        CatView(cat: cat, twoColumns: false, isLoggedIn: true, networkService: MockNetworkManager(), isLiked: true) {}
                    }
                }
                .padding()
            }
        }
    }
}
