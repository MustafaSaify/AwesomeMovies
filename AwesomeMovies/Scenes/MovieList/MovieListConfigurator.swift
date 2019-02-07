//
//  MovieListConfiguration.swift
//  AwesomeMovies
//
//  Created by Mustafa Saify on 02/02/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation
import UIKit

extension MovieListViewController: MovieListPresenterOutput {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.router.passDataToNextScene(segue)
    }
}

extension MovieListInteractor: MovieListViewControllerOutput {}
extension MovieListPresenter: MovieListInteractorOutput {}


class MovieListConfigurator {
    
    // MARK: Object lifecycle
    static let instance = MovieListConfigurator()
    private init() {}
    
    // MARK: Configuration
    func configure(viewController: MovieListViewController) {
        let router = MovieListRouter()
        router.viewController = viewController
        
        let presenter = MovieListPresenter()
        presenter.output = viewController
        
        let interactor = MovieListInteractor()
        interactor.output = presenter
        
        viewController.output = interactor
        viewController.router = router
    }
}
