//
//  MoviesDataSource.swift
//  AwesomeMovies
//
//  Created by Mustafa Saify on 02/02/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation

struct MovieService: Datasource {
    
    fileprivate let synchronizer: Synchronizer
    fileprivate let baseURL: URL
    fileprivate let apiKey: String
    
    init(baseURL: URL, apiKey: String, cacheTime: TimeInterval) {
        self.baseURL = baseURL
        self.synchronizer = Synchronizer(cacheTime: cacheTime)
    }
    
    func getNowPlaying(for region: String?, page: Int?, completion: @escaping ([DataType]) -> ()) {
        synchronizer.cancelSession()
        let resource = NowPlayingMovieResource(baseURL: baseURL, apiKey: apiKey, region: region, page: page)
        //synchronizer.loadPagedResource(resource, pageSize: pageSize, completion: completion)
    }
    
    func searchMovies(for filter: MovieFilter, page: Int?, completion: @escaping ([DataType]) -> ()) {
        
    }
}

