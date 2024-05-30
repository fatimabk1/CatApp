//
//  BannerView.swift
//  CatApp
//
//  Created by Fatima Kahbi on 5/30/24.
//

import SwiftUI

struct BannerView:  View {
    let banner: Banner
    
    var body: some View {
        HStack {
            Image(systemName: "photo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.trailing)
            VStack(alignment: .leading) {
                Text(banner.name)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundStyle(.primary)
                Text(banner.date)
                    .foregroundStyle(.secondary)
                if banner.showCta {
                    HStack {
                        Spacer()
                        NavigationLink {
                            DetailView(catId: banner.id)
                        } label: {
                            Text("View")
                                .foregroundStyle(.secondary)
                                .underline(true)
                        }
                        .buttonStyle(.plain)
                        .padding(.top, 5)
                    }
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
    BannerView(banner: Banner.sampleData[0])
}
