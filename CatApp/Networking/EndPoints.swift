//
//  EndPoints.swift
//  CatApp
//
//  Created by Fatima Kahbi on 5/31/24.
//

import Foundation


enum EndPoints: Equatable {
    case banners
    case cats
    case specificCat(String)
    case login
    case like(String)
    case unlike(String)
    case userLikes
    
    static func ==(lhs: EndPoints, rhs: EndPoints) -> Bool {
        switch (lhs, rhs) {
        case (.banners, .banners), (.cats, .cats), (.login, .login), (.userLikes, .userLikes):
            return true
        case (.specificCat(_), .specificCat(_)), (.like(_), .like(_)), (.unlike(_), .unlike(_)):
            return true
        default:
            return false
        }
    }
}
