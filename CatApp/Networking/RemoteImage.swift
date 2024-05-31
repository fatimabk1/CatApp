//
//  RemoteImage.swift
//  CatApp
//
//  Created by Fatima Kahbi on 5/31/24.
//

import SwiftUI

struct RemoteImage: View {
    let picture: String
    var width: CGFloat = .infinity
    var height: CGFloat = .infinity
    
    var body: some View {
        AsyncImage(url: URL(string: picture)) { image in
            image
                .resizable()
                .scaledToFill()
                .padding()
                .frame(maxWidth: width, maxHeight: height)
                .clipped()
        } placeholder: {
            Image(systemName: "rectangle.fill")
                .resizable()
                .redacted(reason: .placeholder)
                .frame(maxWidth: width, maxHeight: height)
                .clipped()
        }
    }
}

#Preview {
    VStack {
        RemoteImage(picture: "non-url", width: 150, height: 200)
        RemoteImage(picture: "https://picsum.photos/id/1/200/300", width: 150, height: 200)
    }
}
