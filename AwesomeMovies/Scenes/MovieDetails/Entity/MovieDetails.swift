//
//  MovieDetails.swift
//  AwesomeMovies
//
//  Created by Mustafa Saify on 05/02/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation

struct MovieDetails {
    var id: Int
    var title: String
    var duration: TimeInterval?
    var genres: [Genre]
    var rating: Float?
    var votes: Int?
    var description: String?
    var posterPath: String?
    var tagLine: String?
}


struct Genre {
    var id: Int
    var name: String
}
