//
//  ProfileView.swift
//  CatApp
//
//  Created by Fatima Kahbi on 6/3/24.
//

import SwiftUI


struct ProfileView: View {
    @ObservedObject var profileService: ProfileService
    let loginStatus: LoadStatus
    let isLoggedIn: Bool
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Welcome user!")
                    .font(.title)
                    .padding()
                Text("You are \(isLoggedIn ? "logged in." : "logged out.")")
                    .padding()
            }
            Spacer()
            Button {
                if isLoggedIn {
                    profileService.logout()
                } else {
                    profileService.login()
                }
            } label: {
                Text(isLoggedIn ? "Log Out" : "Log In")
                    .padding()
                
            }
            .buttonStyle(.borderedProminent)
            .navigationTitle("Profile")
            .overlay {
                if loginStatus == .loading {
                    ProgressView()
                        .controlSize(.large)
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
            
            if loginStatus == .error {
                Text("Unable to complete action.")
                    .foregroundStyle(.red)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            Spacer()
        }
    }
}

#Preview {
    ProfileView(profileService: ProfileService(networkService: NetworkService()), loginStatus: .error, isLoggedIn: true)
}
