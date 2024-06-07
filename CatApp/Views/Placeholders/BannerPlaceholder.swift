//
//  BannerPlaceholder.swift
//  CatApp
//
//  Created by Fatima Kahbi on 5/31/24.
//

import SwiftUI

struct BannerPlaceholder: View {
    var body: some View {
        HStack {
            Image(systemName: "square.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.trailing)
                .redacted(reason: .placeholder)
            VStack(alignment: .leading) {
                Text("Banner Name Here")
                    .fontWeight(.bold)
                    .foregroundStyle(.primary)
                    .redacted(reason: .placeholder)
                Text("Date")
                    .foregroundStyle(.secondary)
                    .redacted(reason: .placeholder)
                HStack {
                    Spacer()
                    Text("View")
                        .foregroundStyle(.secondary)
                        .underline(true)
                        .redacted(reason: .placeholder)
                    .padding(.top, 5)
                }
            }
        }
        .frame(height: 75)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .foregroundStyle(.teal)
        )
    }
}

#Preview {
    BannerPlaceholder()
}
