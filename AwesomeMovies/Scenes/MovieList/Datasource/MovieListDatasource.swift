//
//  MovieDataSourceInterface.swift
//  AwesomeMovies
//
//  Created by Mustafa Saify on 02/02/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation

protocol MovieListDatasource {
    associatedtype DataType = Movie
    
    func getMovies(for filter: MovieFilterDetails, page: Int?, completion: @escaping (FeedResult<[DataType]>) -> Void) 
}
