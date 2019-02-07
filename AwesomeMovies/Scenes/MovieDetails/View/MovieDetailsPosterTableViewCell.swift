//
//  MovieDetailsPosterTableViewCell.swift
//  AwesomeMovies
//
//  Created by Mustafa Saify on 05/02/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import UIKit

class MovieDetailsPosterTableViewCell: UITableViewCell {
    
    static var reuseIdentifier: String {
        return "\(self)"
    }
    
    @IBOutlet weak var posterImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(for viewModel: MoviePosterDownlodable) {
        if let image = viewModel.posterImage {
            posterImageView.image = image
        }
        else {
            viewModel.download { [weak self] (image) in
                self?.posterImageView.image = image
            }
        }
    }

}
