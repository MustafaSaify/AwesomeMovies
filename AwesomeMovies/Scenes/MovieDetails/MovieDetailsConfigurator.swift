//
//  MovieDetailsConfigurator.swift
//  AwesomeMovies
//
//  Created by Mustafa Saify on 05/02/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation
import UIKit

extension MovieDetailsViewController: MovieDetailsPresenterOutput {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.router.passDataToNextScene(segue)
    }
}

extension MovieDetailsInteractor: MovieDetailsViewControllerOutput {}
extension MovieDetailsPresenter: MovieDetailsInteractorOutput {}


class MovieDetailsConfigurator {
    
    // MARK: Object lifecycle
    static let instance = MovieDetailsConfigurator()
    private init() {}
    
    // MARK: Configuration
    func configure(viewController: MovieDetailsViewController) {
        let router = MovieDetailsRouter()
        router.viewController = viewController
        
        let presenter = MovieDetailsPresenter()
        presenter.output = viewController
        
        let interactor = MovieDetailsInteractor()
        interactor.output = presenter
        
        viewController.output = interactor
        viewController.router = router
    }
}
