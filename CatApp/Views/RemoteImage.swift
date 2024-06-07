//
//  RemoteImage.swift
//  CatApp
//
//  Created by Fatima Kahbi on 5/31/24.
//

import SwiftUI

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
                AsyncImage(url: URL(string: picture)) { phase in
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

struct FrameModifier: ViewModifier {
    let width: CGFloat?
    let height: CGFloat?
    
    func body(content: Content) -> some View {
        if let width, let height {
            if width == .infinity || height == .infinity {
                content.frame(maxWidth: width, maxHeight: height)
            } else {
                content.frame(width: width, height: height)
            }
        } else if let width {
            if width == .infinity{
                content.frame(maxWidth: width)
            } else {
                content.frame(width: width)
            }
        } else if let height {
            if height == .infinity {
                content.frame(maxHeight: height)
            } else {
                content.frame(height: height)
            }
        } else {
            content
        }
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
