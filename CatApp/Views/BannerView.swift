//
//  BannerView.swift
//  CatApp
//
//  Created by Fatima Kahbi on 5/30/24.
//

import SwiftUI



struct BannerView:  View {
    let banner: Banner
    let width: CGFloat = 100
    let height: CGFloat = 140
    
    var body: some View {
        HStack {
            RemoteImage(picture: banner.picture, width: width, height: height)
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
        .frame(width: .infinity, height: 100)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .foregroundStyle(.teal)
        )
    }
    
}

#Preview {
    VStack {
        BannerView(banner: Banner.sampleData[0])
        BannerView(banner: Banner.sampleData[1])
        BannerView(banner: Banner.sampleData[2])
        BannerView(banner: Banner.sampleData[3])
    }
}
