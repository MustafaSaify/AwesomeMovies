//
//  MovieDetailsItemViewModel.swift
//  AwesomeMovies
//
//  Created by Mustafa Saify on 05/02/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation

enum MovieDetailsItem {
    case title
    case duration
    case genres
    case rating
    case description
    
    static var all: [MovieDetailsItem] = [.title, .duration, .genres, .rating, .description]
}
