//
//  ProfileViewModel.swift
//  CatApp
//
//  Created by Fatima Kahbi on 6/6/24.
//

import Foundation
import Combine

/*
 
 TO DO LIST:
 
 - confirm keychain read & print (not persisting login after close/reopen)
 - confirm keychain add, remove and update via testing
 
 - profile service, owned by home screen VM
 - pass as needed.
 - confirm that login persists, and that hear shows/disappears
 - add functionality to clear user likes on logout/remove
 
 - reload specifc cat on like/unlike (to reflect count change)
 - confirm like count changes
 
 - Unit Test everything - fix mock network, start testing
 - Image caching
 */


final class ProfileViewModel: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var loginError: Bool = false
    
    private let keychain = KeychainAccess.standard
    private let networkService: NetworkManager
    private var cancellables = Set<AnyCancellable>()
    
    init(networkService: NetworkManager) {
        self.networkService = networkService
    }
    
    func login() {
        networkService.login()
            .receive(on: RunLoop.main)
            .sink { [weak self] completion in
                if case .failure(_) = completion {
                    self?.loginError = true
                }
            } receiveValue: { [weak self] token in
                if let data = token.token.data(using: .utf8) {
                    print("Login successful. Bearer Token: \n\(data)")
                    self?.keychain.save(data, service: KeychainTokenKey.service.rawValue, account: KeychainTokenKey.account.rawValue)
                    self?.isLoggedIn = true
                }
            }
            .store(in: &cancellables)
    }
    
    func logout() {
        keychain.delete(service: KeychainTokenKey.service.rawValue, account: KeychainTokenKey.account.rawValue)
        isLoggedIn = false
    }
    
    
}
