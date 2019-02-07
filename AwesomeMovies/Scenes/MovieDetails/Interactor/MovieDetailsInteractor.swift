//
//  MovieDetailsInteractor.swift
//  AwesomeMovies
//
//  Created by Mustafa Saify on 05/02/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation


protocol MovieDetailsInteractorInput {
    func fetchMovieDetails(request: MovieDetailsScene.FetchDetails.Request)
}

protocol MovieDetailsInteractorOutput {
    func presentMovieDetails(response: MovieDetailsScene.FetchDetails.Response)
    func presentLoader()
    func dimissLoader()
}

class MovieDetailsInteractor: MovieDetailsInteractorInput {
    
    var output: MovieDetailsInteractorOutput!
    var movie: Movie!
    lazy var worker: MovieDetailsWorker = MovieDetailsWorker()
    fileprivate lazy var imageAccess: NetworkImageAccess = NetworkImageAccess(cacheTime: 24 * oneHour)
    
    func fetchMovieDetails(request: MovieDetailsScene.FetchDetails.Request) {
        output.presentLoader()
        worker.getDetails(for: request.movieId) { [weak self] (result) in
            switch result {
            case .success(let movieDetails):
                let response = MovieDetailsScene.FetchDetails.Response(details: movieDetails,
                                                                       imageAccess: self?.imageAccess,
                                                                       error: nil)
                self?.output.presentMovieDetails(response: response)
            case .error(let error):
                let response = MovieDetailsScene.FetchDetails.Response(details: nil,
                                                                       imageAccess: self?.imageAccess,
                                                                       error: error)
                self?.output.presentMovieDetails(response: response)
            case .noData:
                let response = MovieDetailsScene.FetchDetails.Response(details: nil,
                                                                       imageAccess: self?.imageAccess,
                                                                       error: SynchronizerError.wrongStatusError(status: 404))
                self?.output.presentMovieDetails(response: response)
            }
            self?.output.dimissLoader()
        }
    }
}
