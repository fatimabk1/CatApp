//
//  EndPointService.swift
//  CatApp
//
//  Created by Fatima Kahbi on 5/31/24.
//

import Foundation


final class EndPointService {
    private let baseUrl             = "https://show-your-cat.onrender.com"
    private let endpointLike        = "/like"           // endpoint: /cats/<cat_id>/like
    private let endpointUnlike      = "/unlike"           // endpoint: /cats/<cat_id>/unlike
    private let endpointUserLikes   = "/user/likes"
    
    func getURL(endpoint: EndPoints) -> Result<URL, NetworkError> {
        var urlComponents = URLComponents(string: baseUrl)!
        
        switch endpoint {
        case .banners:
            urlComponents.path = "/banner"
        case .cats:
            urlComponents.path = "/cats/"
        case .specificCat(let catId):
            urlComponents.path = "/cats/\(catId)"
        case .login:
            urlComponents.path = "/auth/login"
        case .like(let catId):
            urlComponents.path = "/cats/\(catId)/like"
        case .unlike(let catId):
            urlComponents.path = "/cats/\(catId)/unlike"
        case .userLikes:
            urlComponents.path = "/user/likes"
        }
        guard let url = urlComponents.url else {
            return .failure(.badURL)
        }
        return .success(url)
    }
}
