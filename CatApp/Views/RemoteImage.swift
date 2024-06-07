//
//  RemoteImage.swift
//  CatApp
//
//  Created by Fatima Kahbi on 5/31/24.
//

import SwiftUI
import CachedAsyncImage

struct RemoteImage: View {
    let picture: String
    let width: CGFloat?
    let height: CGFloat?
    
    init(picture: String, width: CGFloat? = nil, height: CGFloat? = nil) {
        self.picture = picture
        self.width = width
        self.height = height
    }
    
    var body: some View {
        Color.clear
            .background(
                CachedAsyncImage(url: URL(string: picture)) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipShape(Rectangle())
                    case .failure:
                        Rectangle()
                            .foregroundStyle(.gray.opacity(0.3))
                            .overlay {
                                Image(systemName: "exclamationmark.triangle")
                                    .resizable()
                                    .scaleEffect(1/4)
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundStyle(.gray)
                            }
                    case .empty:
                        ProgressView()
                            .controlSize(.large)
                    @unknown default:
                        ProgressView()
                    }
                }
            )
            .modifier(FrameModifier(width: width, height: height))
            .aspectRatio(1, contentMode: .fill)
            .clipped()
    }
}



#Preview {
    ScrollView {
        VStack {
            RemoteImage(picture: "https://picsum.photos/id/1/200/300", height: 200)
            RemoteImage(picture: "non-url", width: 100, height: 200)
            RemoteImage(picture: "non-url", width: 50)
            RemoteImage(picture: "https://picsum.photos/if9sd0f890s/300")
            
        }
    }
}
