//
//  MovieController.swift
//  Assessment 3
//
//  Created by Hin Wong on 3/13/20.
//  Copyright © 2020 Hin Wong. All rights reserved.
//

import UIKit

class MovieController {
    
    //MARK: - Properties
    static private let baseURL = URL(string: "https://api.themoviedb.org/3/search/movie")
    static private let apiKeyQueryItem = "api_key"
    static private let apiKey = "1536949f0aae28c903b74f3f48a934b5"
    
    
    static func fetchMovie(searchTerm: String, completion: @escaping (Result<[Movie], MovieError>) -> Void) {
        
        // 1. URL
        guard let baseURL = baseURL else {return completion(.failure(.invalidURL))}
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
    
        urlComponents?.queryItems = [URLQueryItem(name: apiKeyQueryItem, value: apiKey), URLQueryItem(name: "query", value: searchTerm)]
        
        guard let finalURL = urlComponents?.url else {return completion(.failure(.invalidURL))}
        print(finalURL)
        
        // 2. Data task
    URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            
        // 3. Error handling
        if let error = error {
            print(error, error.localizedDescription)
            return completion(.failure(.thrown(error)))
        }
        
        // 4. Check for data
        guard let data = data else {return completion(.failure(.noData))}
        
        // 5. Decode data
        do {
            let topLevelObject = try JSONDecoder().decode(TopLevelObject.self, from: data)
            completion(.success(topLevelObject.results))
        } catch {
            print(error, error.localizedDescription)
            return completion(.failure(.thrown(error)))
        }
        
        }.resume()
    }
    static func fetchMovieThumbnail(for movie: Movie, completion: @escaping (Result<UIImage, MovieError>) -> Void) {
        
        guard let movieThumbnail = movie.thumbnail else {return}
        
        let imageBaseURL = URL(string: "https://image.tmdb.org/t/p/w500")
        
        guard let posterURL = imageBaseURL?.appendingPathComponent(movieThumbnail) else { return }
        print(posterURL)
        
        URLSession.shared.dataTask(with: posterURL) { (data, _, error) in
            
            if let error = error {
                print(error, error.localizedDescription)
                completion(.failure(.thrown(error)))
            }
            
            guard let data = data else {return completion(.failure(.noData))}
            
            guard let image = UIImage(data: data) else {return completion(.failure(.noData))}
            completion(.success(image))
            
        }.resume()
}
}
