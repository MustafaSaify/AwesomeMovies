//
//  MovieDetailsDataSource.swift
//  AwesomeMovies
//
//  Created by Mustafa Saify on 05/02/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation

protocol MovieDetailsDatasource {
    associatedtype DataType = MovieDetails
    
    func getDetails(for movieId: Int, completion: @escaping (SynchronizerResult<DataType>) -> Void)
}
