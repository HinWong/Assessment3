//
//  MovieError.swift
//  Assessment 3
//
//  Created by Hin Wong on 3/13/20.
//  Copyright © 2020 Hin Wong. All rights reserved.
//

import Foundation

enum MovieError: LocalizedError {
    
    // What we see
    case invalidURL
    case thrown(Error)
    case noData
    case unableToDecode
    
    // What the user sees
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Unable to reach server."
        case .thrown(let error):
            return error.localizedDescription
        case .noData:
            return "Server responded with no data."
        case .unableToDecode:
            return "Server responded with bad data."
        }
    }
}
