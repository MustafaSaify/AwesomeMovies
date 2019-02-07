//
//  MovieDetailsViewController.swift
//  AwesomeMovies
//
//  Created by Mustafa Saify on 05/02/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import UIKit

protocol MovieDetailsViewControllerInput {
    func displayMovieDetails(viewModel: MovieDetailsScene.FetchDetails.ViewModel)
    func showLoader()
    func hideLoader()
}

protocol MovieDetailsViewControllerOutput {
    var movie: Movie! { get set }
    func fetchMovieDetails(request: MovieDetailsScene.FetchDetails.Request)
}

class MovieDetailsViewController: UIViewController {
    
    var output: MovieDetailsViewControllerOutput!
    var router: MovieDetailsRouter!
    fileprivate var poster: MovieDetailsPosterViewModel?
    fileprivate var details: [MovieDetailsListable] = []
    @IBOutlet weak var tableView: UITableView!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        MovieDetailsConfigurator.instance.configure(viewController: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        MovieDetailsConfigurator.instance.configure(viewController: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMovieDetailsOnLoad()
    }
    
    fileprivate func fetchMovieDetailsOnLoad() {
        output.fetchMovieDetails(request: MovieDetailsScene.FetchDetails.Request(movieId: output.movie.id))
    }

}

extension MovieDetailsViewController: MovieDetailsViewControllerInput {
    
    func displayMovieDetails(viewModel: MovieDetailsScene.FetchDetails.ViewModel) {
        if let error = viewModel.error {
            displayError(with: "Error", message: error)
            return
        }
        self.details = viewModel.items
        self.poster = viewModel.posterModel
        tableView.reloadData()
    }
    
    func displayError(with title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    func showLoader() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
    }
    
    func hideLoader() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
}

extension MovieDetailsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return poster != nil ? 1 : 0
        }
        return details.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieDetailsPosterTableViewCell.reuseIdentifier, for: indexPath) as? MovieDetailsPosterTableViewCell else {
                assertionFailure("Unable to initialize cell: \(MovieDetailsPosterTableViewCell.reuseIdentifier)")
                return MovieDetailsPosterTableViewCell()
            }
            cell.configure(for: poster!)
            return cell
        }

        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieDetailsItemTableViewCell.reuseIdentifier, for: indexPath) as? MovieDetailsItemTableViewCell else {
            assertionFailure("Unable to initialize cell: \(MovieDetailsItemTableViewCell.reuseIdentifier)")
            return MovieDetailsItemTableViewCell()
        }
        cell.configure(for: details[indexPath.row])
        return cell
    }
}
