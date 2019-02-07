//
//  MovieDetailsItemTableViewCell.swift
//  AwesomeMovies
//
//  Created by Mustafa Saify on 05/02/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import UIKit

class MovieDetailsItemTableViewCell: UITableViewCell {
    
    static var reuseIdentifier: String {
        return "\(self)"
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var containerStackView: UIStackView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(for viewModel: MovieDetailsListable) {
        titleLabel.text = viewModel.titleText
        titleLabel.font = viewModel.titleFont
        titleLabel.textColor = viewModel.titleColor
        
        detailsLabel.text = viewModel.detailsText
        detailsLabel.font = viewModel.detailsFont
        detailsLabel.textColor = viewModel.detailsColor
        detailsLabel.textAlignment = viewModel.detailsTextAlignment
        
        containerStackView.axis = viewModel.containerStackAxis
    }

}
