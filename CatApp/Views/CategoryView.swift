//
//  CategoryView.swift
//  CatApp
//
//  Created by Fatima Kahbi on 5/30/24.
//

import SwiftUI

struct CategoryView:  View {
    let category: String
    @Binding var selectedCategory: String?
    var isSelected: Bool { selectedCategory == category }
    
    var body: some View {
        Button {
            if isSelected { // unselect when already selected
                selectedCategory = ""
            } else {
                selectedCategory = category
            }
        } label: {
            VStack {
                Image(systemName: "cat.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .frame(width: 50, height: 50)
                    .foregroundStyle(.purple.opacity(isSelected ? 1.0 : 0.5))
                
                Text(category.capitalized) // TODO: move to VM?
                    .font(.callout)
                    .foregroundStyle(.primary)
            }
            .padding()
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    Group {
        CategoryView(category: "Friendly", selectedCategory: .constant("Friendly"))
        CategoryView(category: "Shy", selectedCategory: .constant("Friendly"))
    }
}
