//
//  MovieListPresenter.swift
//  AwesomeMovies
//
//  Created by Mustafa Saify on 02/02/19.
//  Copyright (c) 2019 Mustafa Saify. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol MovieListPresenterInput {
    func presentMovies(response: MovieList.FetchMovies.Response)
    func presentFooter(response: MovieList.Footer.Response)
}

protocol MovieListPresenterOutput: class {
    func displayMovies(viewModel: MovieList.FetchMovies.ViewModel)
    func displayFooter(viewModel: MovieList.Footer.ViewModel)
}

class MovieListPresenter: MovieListPresenterInput {
    
    weak var output: MovieListPresenterOutput!
    
    func presentMovies(response: MovieList.FetchMovies.Response) {
        let moviesViewModels = response.movies?.map { MovieViewModel(with: $0, imageDownloader: response.imageAccess) }
        output.displayMovies(viewModel: MovieList.FetchMovies.ViewModel(movies: moviesViewModels,
                                                                        append: response.append,
                                                                        error: response.error?.message))
    }
    
    func presentFooter(response: MovieList.Footer.Response) {
        let footerViewModel = MovieListFooterViewModel(loadingState: response.state)
        output.displayFooter(viewModel: MovieList.Footer.ViewModel(footerViewModel: footerViewModel))
    }

}

extension Error {
    
    var message: String {
        if let syncronizerError = self as? SynchronizerError {
            switch syncronizerError {
            case .urlSessionError(let other):
                return other.localizedDescription
            default:
                return "Something went wrong."
            }
        }
        return "Something went wrong."
    }
}