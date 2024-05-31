//
//  CategoryPlaceholder.swift
//  CatApp
//
//  Created by Fatima Kahbi on 5/31/24.
//

import SwiftUI

struct CategoryPlaceholder:  View {
    var body: some View {
        VStack {
            Image(systemName: "circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(Circle())
                .frame(width: 50, height: 50)
                .foregroundStyle(.purple)
                .redacted(reason: .placeholder)
            Text("Category")
                .font(.callout)
                .foregroundStyle(.primary)
                .redacted(reason: .placeholder)
        }
        .padding()
        
    }
}

#Preview {
    CategoryPlaceholder()
}
