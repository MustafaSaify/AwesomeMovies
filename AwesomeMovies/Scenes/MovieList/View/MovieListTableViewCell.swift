//
//  MovieListTableViewCell.swift
//  AwesomeMovies
//
//  Created by Mustafa Saify on 04/02/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import UIKit
import RxSwift

class MovieListTableViewCell: UITableViewCell {
    
    static var reuseIdentifier: String {
        return "\(self)"
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    
    var viewModel: MovieViewModel!
    var rxDisposeBag: DisposeBag?
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        containerView.layer.cornerRadius = 5.0
        containerView.layer.masksToBounds = true
    }
    
    override func prepareForReuse() {
        viewModel.cancelImageDownload()
        rxDisposeBag = DisposeBag()
    }
    
    func configure(with viewModel: MovieViewModel) {
        self.viewModel = viewModel
        titleLabel.text = viewModel.title
        releaseDateLabel.text = viewModel.releaseDateText
        posterImageView.image = viewModel.posterImage
        
        if viewModel.posterImage == nil {
            observePosterImageDownload()
            viewModel.downloadPoster()
        }
    }
}

extension MovieListTableViewCell {
    
    fileprivate func observePosterImageDownload() {
        _ = viewModel.rxPosterImage().subscribe(onNext: { [weak self] (image) in
            self?.posterImageView?.image = image
        })
    }
}
