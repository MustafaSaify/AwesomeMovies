//
//  MovieDataSourceInterface.swift
//  AwesomeMovies
//
//  Created by Mustafa Saify on 02/02/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation

protocol Datasource {
    associatedtype DataType = Movie
    
    func getNowPlaying(for region: String?, page: Int?, completion: @escaping ([DataType]) -> ())
    func searchMovies(for filter: MovieFilter, page: Int?, completion: @escaping ([DataType]) -> ())
}
