//
//  ProfileView.swift
//  CatApp
//
//  Created by Fatima Kahbi on 6/3/24.
//

import SwiftUI



struct ProfileView: View {
    @ObservedObject var viewModel: ProfileViewModel
    
    var body: some View {
        Button {
            if viewModel.isLoggedIn {
                viewModel.logout()
            } else {
                viewModel.login()
            }
        } label: {
            Text(viewModel.isLoggedIn ? "Log Out" : "Log In")
        }
    }
}

#Preview {
    ProfileView(viewModel: ProfileViewModel(networkService: NetworkService()))
}
