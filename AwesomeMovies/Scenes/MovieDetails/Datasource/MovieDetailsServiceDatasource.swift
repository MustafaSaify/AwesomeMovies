//
//  MovieDetailsServiceDatasource.swift
//  AwesomeMovies
//
//  Created by Mustafa Saify on 05/02/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation

struct MovieDetailsServiceDatasource: MovieDetailsDatasource {
    
    fileprivate let synchronizer: Synchronizer
    fileprivate let baseURL: URL
    fileprivate let apiKey: String
    
    init(baseURL: URL, apiKey: String, cacheTime: TimeInterval) {
        self.baseURL = baseURL
        self.apiKey = apiKey
        self.synchronizer = Synchronizer(cacheTime: cacheTime)
    }
    
    func getDetails(for movieId: Int, completion: @escaping (SynchronizerResult<MovieDetails>) -> Void) {
        synchronizer.cancelSession()
        let resource = MovieDetailsResource(baseURL: baseURL, apiKey: apiKey, movieId: movieId)
        _ = synchronizer.loadResource(resource, completion: completion)
    }
}
