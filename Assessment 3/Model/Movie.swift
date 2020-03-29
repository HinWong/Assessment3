//
//  Movie.swift
//  Assessment 3
//
//  Created by Hin Wong on 3/13/20.
//  Copyright © 2020 Hin Wong. All rights reserved.
//

import Foundation

struct TopLevelObject:Codable {
    let results: [Movie]
}

struct Movie: Codable {
    let title: String
    let overview: String
    let thumbnail: String?
    let ratings: Float
    
    enum CodingKeys: String, CodingKey {
        case title
        case overview = "overview"
        case thumbnail = "poster_path"
        case ratings = "vote_average"
    }
}
