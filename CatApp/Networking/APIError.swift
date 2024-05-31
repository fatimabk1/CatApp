//
//  APIError.swift
//  CatApp
//
//  Created by Fatima Kahbi on 5/31/24.
//

import Foundation


struct APIError: Decodable, Error {
    let errorCode: Int
    let message: String

    enum CodingKeys: String, CodingKey {
        case errorCode = "code"
        case message
    }
}
