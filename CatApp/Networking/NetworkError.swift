//
//  NetworkError.swift
//  CatApp
//
//  Created by Fatima Kahbi on 6/5/24.
//

import Foundation


enum NetworkError: Error {
    case noInternet
    case badURL
    case failedToComplete
    case invalidResponse
    case invalidData
    case invalidRequest
}
