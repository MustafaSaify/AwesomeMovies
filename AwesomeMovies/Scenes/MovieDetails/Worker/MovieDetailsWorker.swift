//
//  MovieDetailsWorker.swift
//  AwesomeMovies
//
//  Created by Mustafa Saify on 05/02/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation

private let baseURL = URL(string: Bundle.main.apiBaseUrl())!
private let apiKey = Bundle.main.apiKey()

class MovieDetailsWorker {
    
    private let dataManager = MovieDetailsDataManager(dataSource: MovieDetailsServiceDatasource(baseURL: baseURL,
                                                                                                apiKey: apiKey,
                                                                                                cacheTime: oneHour))
    
    func getDetails(for movieId: Int, completion: @escaping (SynchronizerResult<MovieDetails>) -> Void) {
        dataManager.getDetails(for: movieId, completion: completion)
    }
}
