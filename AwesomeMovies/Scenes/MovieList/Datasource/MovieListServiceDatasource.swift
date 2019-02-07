//
//  MoviesDataSource.swift
//  AwesomeMovies
//
//  Created by Mustafa Saify on 02/02/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation

struct MovieListServiceDatasource: MovieListDatasource {
    
    fileprivate let synchronizer: Synchronizer
    fileprivate let baseURL: URL
    fileprivate let apiKey: String
    
    init(baseURL: URL, apiKey: String, cacheTime: TimeInterval) {
        self.baseURL = baseURL
        self.apiKey = apiKey
        self.synchronizer = Synchronizer(cacheTime: cacheTime)
    }
    
    
    func getMovies(for filter: MovieFilterDetails, page: Int?, completion: @escaping (FeedResult<[Movie]>) -> Void) {
        synchronizer.cancelSession()
        let resource = DiscoverMovieResource(baseURL: baseURL, apiKey: apiKey, minYear: filter.minYear, maxYear: filter.maxYear, page: page)
        synchronizer.loadPagedResource(resource, completion: completion)
    }
}

