//
//  MovieTableViewCell.swift
//  Assessment 3
//
//  Created by Hin Wong on 3/13/20.
//  Copyright © 2020 Hin Wong. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    var movie: Movie? {
        didSet {
            guard let movie = movie else {return}
            movieTitleLabel.text = movie.title
            movieOverview.text = movie.overview
            ratingLabel.text = String(movie.ratings)
            
            MovieController.fetchMovieThumbnail(for: movie) { (result) in
                switch result {
                    
                case .success(let image):
                    DispatchQueue.main.async {
                        self.movieImage.image = image
                    }
                case .failure(let error):
                    print(error, error.localizedDescription)
                }
            }
        }
    }
}
