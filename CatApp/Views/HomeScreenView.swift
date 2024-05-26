//
//  HomeScreenView.swift
//  CatApp
//
//  Created by Fatima Kahbi on 5/25/24.
//

import SwiftUI

/*
 Home Screen
 - Title, Profile Button
 - Horizontal scroll of banners
 - Category
    - Horizontal scroll of category icons
 - Vertical scroll of cat thumbnails
 - pull cats, banner onAppear. Calculate & display categories
 */

struct HomeScreenView: View {
    @ObservedObject var viewModel = HomeScreenViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("hi")
            }
            .navigationTitle("Cat Tree")
        }
    }
}

#Preview {
    HomeScreenView()
}

 
/*
 POA

 Home Screen
 - Title, Profile Button
 - Horizontal scroll of banners
 - Category
    - Horizontal scroll of category icons
 - Vertical scroll of cat thumbnails
 - pull cats, banner onAppear. Calculate & display categories
 
 --> cat and banner go to cat detail
 
 CatDetail Screen
 - takes a catDetail
 - Image, name, etc.
 
 Components
 - bannerView
    - Name, date, image, button?
 - categoryIcon
    - icon, image (circualar)
 - catThumbnailView
    - image, name, date, likes, heart button
 
 */
