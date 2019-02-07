//
//  MovieFilterRouter.swift
//  AwesomeMovies
//
//  Created by Mustafa Saify on 06/02/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation

class MovieFilterRouter {
    
    weak var viewController: MovieFilterViewController!
    
    
    func passDataToMovieList() {
        guard let presentingNavigationVC = viewController.navigationController?.presentingViewController as? UINavigationController,
              let movieListVC = presentingNavigationVC.viewControllers.first as? MovieListViewController
        else {
            return
        }
        movieListVC.output.filterDetails = viewController.output.filterDetails
    }
}
