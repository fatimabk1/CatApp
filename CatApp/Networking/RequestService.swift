//
//  RequestService.swift
//  CatApp
//
//  Created by Fatima Kahbi on 6/6/24.
//

import Foundation


final class RequestService {
    private let endpointsNeedingAuthorization: [EndPoints] = [.unlike(""), .like(""), .userLikes]
    private var request: URLRequest?
    private var endpoint: EndPoints?
    
    func configureRequest(url: URL, endpoint: EndPoints) -> Result<URLRequest, NetworkError> {
        self.request = URLRequest(url: url)
        self.endpoint = endpoint
        
        configureHTTPMethod()
        configureBody()
        configureHeader()
        
        print("Request Configured...")
        print(request)
        
        if let request {
            return .success(request)
        }
        return .failure(NetworkError.badURL)
    }
    
    private func configureHTTPMethod() {
        guard let endpoint else { return }
        switch endpoint {
        case .banners, .cats, .userLikes, .specificCat:
            request?.httpMethod = "GET"
            
        case .like, .unlike, .login:
            request?.httpMethod = "POST"
        }
    }
    
    private func configureBody() {
        if endpoint == .login {
            request?.addValue("application/json", forHTTPHeaderField: "Content-Type")
            let parameters = ["username": "tech-challenge@showyourcat.com", "password": "Testing1!"]
            if let jsonData = try? JSONSerialization.data(withJSONObject: parameters) {
                request?.httpBody = jsonData
            }
        }
    }
    
    private func configureHeader() {
        guard let endpoint else { return }
        if needsAuthorization(endpoint: endpoint) {
            // TODO: REPLACE WITH VARIABLE ACCESS TOKEN
            let token = KeychainAccess.standard.read(service: KeychainTokenKey.service.rawValue, account: KeychainTokenKey.account.rawValue)
            if let token, let tokenString = String(data: token, encoding: .utf8) {
                print("Bearer Token: \(tokenString)") // Debug print
                request?.addValue("Bearer \(tokenString)", forHTTPHeaderField: "Authorization")
            } else {
                print("token not found or invalid")
            }
        } else {
            print("authorization not required")
        }
    }
    
    private func needsAuthorization(endpoint: EndPoints) -> Bool {
            return endpointsNeedingAuthorization.contains(where: { $0 == endpoint })
        }
}
