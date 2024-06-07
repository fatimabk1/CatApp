//
//  ProfileView.swift
//  CatApp
//
//  Created by Fatima Kahbi on 6/3/24.
//

import SwiftUI


struct ProfileView: View {
    @ObservedObject var profileService: ProfileService
    let isLoggedIn: Bool
    
    var body: some View {
        Button {
            if isLoggedIn {
                profileService.logout()
            } else {
                profileService.login()
            }
        } label: {
            Text(isLoggedIn ? "Log Out" : "Log In")
        }
    }
}

#Preview {
    ProfileView(profileService: ProfileService(networkService: NetworkService()), isLoggedIn: true)
}
