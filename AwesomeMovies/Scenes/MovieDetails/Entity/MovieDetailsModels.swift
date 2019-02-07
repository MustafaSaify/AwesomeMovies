//
//  MovieDetailsModel.swift
//  AwesomeMovies
//
//  Created by Mustafa Saify on 05/02/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation

enum MovieDetailsScene {
    
    enum FetchDetails {
        
        struct Request {
            var movieId: Int
        }
        
        struct Response {
            var details: MovieDetails?
            var imageAccess: ImageAccess?
            var error: Error?
        }
        
        struct ViewModel {
            var items: [MovieDetailsListable]
            var posterModel: MovieDetailsPosterViewModel?
            var error: String?
        }
    }
}
