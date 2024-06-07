//
//  BannerView.swift
//  CatApp
//
//  Created by Fatima Kahbi on 5/30/24.
//

import SwiftUI



struct BannerView:  View {
    let banner: Banner
    let networkService: NetworkManager
    let width: CGFloat = 100
    let height: CGFloat = 140
    
    var body: some View {
        HStack {
            RemoteImage(picture: banner.picture, width: 100, height: 100)
                .padding(.trailing)
            VStack(alignment: .leading) {
                bannerInfo
                if banner.showCta {
                    ctaButton
                }
            }
            .frame(maxWidth: .infinity)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .foregroundStyle(.teal)
        )
    }
    
    private var bannerInfo: some View {
        Group {
            Text(banner.name)
                .fontWeight(.bold)
                .foregroundStyle(.primary)
            Text(banner.date)
                .foregroundStyle(.secondary)
        }
    }
    
    private var ctaButton: some View {
        HStack {
            Spacer()
            NavigationLink {
                DetailView(catId: banner.id, networkService: networkService)
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

#Preview {
    VStack {
        BannerView(banner: Banner.sampleData[0], networkService: MockNetworkManager())
        BannerView(banner: Banner.sampleData[1], networkService: MockNetworkManager())
        BannerView(banner: Banner.sampleData[2], networkService: MockNetworkManager())
        BannerView(banner: Banner.sampleData[3], networkService: MockNetworkManager())
    }
}
