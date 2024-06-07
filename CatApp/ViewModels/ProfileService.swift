//
//  ProfileService.swift
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


final class ProfileService: ObservableObject {
    var isLoggedIn = CurrentValueSubject<Bool, Never>(false)
    var loginLoadStatus = CurrentValueSubject<LoadStatus, Never>(LoadStatus.empty)
    
    private let keychain = KeychainAccess.standard
    private let networkService: NetworkManager
    private var cancellables = Set<AnyCancellable>()
    
    init(networkService: NetworkManager) {
        self.networkService = networkService
        if keychain.read(service: KeychainTokenKey.service.rawValue, account: KeychainTokenKey.account.rawValue) != nil {
            self.isLoggedIn.send(true)
        }
    }
    
    func login() {
        loginLoadStatus.send(.loading)
        networkService.login()
            .receive(on: RunLoop.main)
            .sink { [weak self] completion in
                if case .failure(_) = completion {
                    self?.loginLoadStatus.send(.error)
                }
            } receiveValue: { [weak self] token in
                if let data = token.token.data(using: .utf8) {
                    self?.keychain.save(data, service: KeychainTokenKey.service.rawValue, account: KeychainTokenKey.account.rawValue)
                    self?.isLoggedIn.send(true)
                    self?.loginLoadStatus.send(.loaded)
                }
            }
            .store(in: &cancellables)
    }
    
    func logout() {
        keychain.delete(service: KeychainTokenKey.service.rawValue, account: KeychainTokenKey.account.rawValue)
        isLoggedIn.send(false)
    }
    
    
}
