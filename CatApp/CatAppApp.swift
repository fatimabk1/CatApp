//
//  CatAppApp.swift
//  CatApp
//
//  Created by Fatima Kahbi on 5/25/24.
//

import SwiftUI

@main
struct CatAppApp: App {
    let networkService = NetworkService()
//    let networkService = MockNetworkManager()
    
    var body: some Scene {
        WindowGroup {
            HomeScreenView(networkService: networkService)
        }
    }
}
