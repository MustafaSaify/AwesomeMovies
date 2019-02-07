//
//  MovieListPresenter.swift
//  AwesomeMovies
//
//  Created by Mustafa Saify on 05/02/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation

protocol MovieDetailsPresenterInput {
    func presentMovieDetails(response: MovieDetailsScene.FetchDetails.Response)
    func presentLoader()
    func dimissLoader()
}

protocol MovieDetailsPresenterOutput {
    func displayMovieDetails(viewModel: MovieDetailsScene.FetchDetails.ViewModel)
    func showLoader()
    func hideLoader()
}

class MovieDetailsPresenter: MovieDetailsPresenterInput {
    
    var output: MovieDetailsPresenterOutput!
    
    func presentMovieDetails(response: MovieDetailsScene.FetchDetails.Response) {
        guard let details = response.details else {
            let viewModel = MovieDetailsScene.FetchDetails.ViewModel(items: [],
                                                                     posterModel: nil,
                                                                     error: response.error?.message)
            output.displayMovieDetails(viewModel: viewModel)
            return
        }
        var viewModels = [MovieDetailsListable]()
        let items = MovieDetailsItem.all
        items.forEach { (item) in
            var viewModel: MovieDetailsListable
            switch item {
            case .title:
                viewModel = MovieDetailsTitleViewModel(with: details.title, tagLine: details.tagLine)
            case .duration:
                viewModel = MovieDetailsDurationViewModel(with: details.duration)
            case .genres:
                viewModel = MovieDetailsGenresViewModel(with: details.genres)
            case .rating:
                viewModel = MovieDetailsRatingsViewModel(with: details.rating, votesCount: details.votes)
            case .description:
                viewModel = MovieDetailsDescriptionViewModel(with: details.description)
            }
            viewModels.append(viewModel)
        }
        let posterViewModel = MovieDetailsPosterViewModel(with: details.posterPath, imageAccess: response.imageAccess)
        
        let viewModel = MovieDetailsScene.FetchDetails.ViewModel(items: viewModels,
                                                                 posterModel: posterViewModel,
                                                                 error: nil)
        output.displayMovieDetails(viewModel: viewModel)
    }
    
    func presentLoader() {
        output.showLoader()
    }
    
    func dimissLoader() {
        output.hideLoader()
    }
    
}
