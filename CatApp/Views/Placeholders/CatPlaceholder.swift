//
//  CatPlaceholder.swift
//  CatApp
//
//  Created by Fatima Kahbi on 5/31/24.
//

import SwiftUI

struct CatPlaceholder:  View {
    var body: some View {
        VStack(alignment: .leading) {
            Image(systemName: "rectangle.fill")
                .resizable()
                .aspectRatio(1.25, contentMode: .fit)
                .frame(maxWidth: .infinity)
                .redacted(reason: .placeholder)
                .padding(.bottom)
            HStack {
                Text("Felix")
                    .font(.title3)
                    .fontWeight(.bold)
                    .redacted(reason: .placeholder)
                Spacer()
                Text("243  ")
                    .redacted(reason: .placeholder)
            }
            .padding(.bottom, 5)
            HStack {
                Text("Sex: ")
                    .fontWeight(.semibold)
                    .redacted(reason: .placeholder)
                Text("Male")
                    .redacted(reason: .placeholder)
            }
            .padding(.bottom, 10)
            Text("Categories: ")
                .fontWeight(.semibold)
                .redacted(reason: .placeholder)
            Text("Cuddly, Cute, Adventurous")
                .redacted(reason: .placeholder)
            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .foregroundStyle(.pink)
        )
        
        .buttonStyle(.plain)
        .frame(maxHeight: .infinity)
    }
}

#Preview {
    var columns: [GridItem] {
        [GridItem(), GridItem()]
    }
    
    return Group {
        VStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(Cat.sampleData, id: \.id) { cat in
                        CatPlaceholder()
                    }
                }
            }
        }
    }
}
