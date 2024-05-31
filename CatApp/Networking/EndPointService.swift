//
//  EndPointService.swift
//  CatApp
//
//  Created by Fatima Kahbi on 5/31/24.
//

import Foundation


final class EndPointService {
    private let baseUrl             = "https://show-your-cat.onrender.com"
    private let endpointBanners     = "/banner"
    private let endpointCats        = "/cats/"
    private let endpointSpecificCat = "/cats/"
    //    private let endpointLogin       = "/auth/login"
    //    private let endpointLike        = "/like"           // endpoint: /cats/<cat_id>/like
    //    private let endpointUnlike      = "/unlike"           // endpoint: /cats/<cat_id>/unlike
    //    private let endpointUserLikes   = "/user/likes"
    
    func getURL(endpoint: EndPoints, parameter: String? = nil) -> Result<URL, EndPointError> {
        var urlString = ""
        
        switch endpoint {
        case .banners:
            urlString = baseUrl + endpointBanners
        case .cats:
            urlString = baseUrl + endpointCats
        case .specificCat:
            if let parameter {
                urlString = baseUrl + endpointSpecificCat + parameter
            }
        }
        
        guard let url = URL(string: urlString) else {
            return .failure(.invalidURL)
        }
        return .success(url)
    }
}
