//
//  CatView.swift
//  CatApp
//
//  Created by Fatima Kahbi on 5/30/24.
//

import SwiftUI

struct CatView:  View {
    let cat: Cat
    var categories: String {
        cat.categories.joined(separator: ", ").capitalized
    }
    
    var body: some View {
        NavigationLink {
            DetailView(catId: cat.id)
        } label: {
            VStack(alignment: .leading) {
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .padding(.bottom)
                HStack {
                    Text(cat.name)
                        .font(.title3)
                        .fontWeight(.bold)
                    Spacer()
                    Text("\(cat.likes)")
                    Image(systemName: "heart")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 15)
                }
                .padding(.bottom, 5)
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
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .foregroundStyle(.pink)
            )
        }
        .buttonStyle(.plain)
        .frame(maxHeight: .infinity)
    }
}

#Preview {
    var columns: [GridItem] {
        [GridItem(), GridItem()]
    }
    
    return VStack {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(Cat.sampleData, id: \.id) { cat in
                    CatView(cat: cat)
                       
                }
            }
        }
    }
}
