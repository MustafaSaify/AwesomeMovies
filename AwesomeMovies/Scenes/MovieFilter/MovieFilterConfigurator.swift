//
//  MovieFilterOcnfigurator.swift
//  AwesomeMovies
//
//  Created by Mustafa Saify on 06/02/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation

extension MovieFilterViewController: MovieFilterPresenterOutput {
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        self.router.passDataToNextScene(segue)
//    }
}

extension MovieFilterInteractor: MovieFilterViewControllerOutput {}
extension MovieFilterPresenter: MovieFilterInteractorOutput {}


class MovieFilterConfigurator {
    
    // MARK: Object lifecycle
    static let instance = MovieFilterConfigurator()
    private init() {}
    
    // MARK: Configuration
    func configure(viewController: MovieFilterViewController) {
        let router = MovieFilterRouter()
        router.viewController = viewController
        
        let presenter = MovieFilterPresenter()
        presenter.output = viewController
        
        let interactor = MovieFilterInteractor()
        interactor.output = presenter
        
        viewController.output = interactor
        viewController.router = router
    }
}
