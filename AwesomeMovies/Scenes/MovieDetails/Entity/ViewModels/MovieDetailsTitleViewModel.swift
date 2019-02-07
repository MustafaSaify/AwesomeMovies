//
//  MovieDetailsTitleViewModel.swift
//  AwesomeMovies
//
//  Created by Mustafa Saify on 05/02/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation
import UIKit

struct MovieDetailsTitleViewModel: MovieDetailsListable {
    
    var titleText: String?
    
    var detailsText: String?
    
    var titleFont: UIFont? {
        return UIFont.boldSystemFont(ofSize: 20.0)
    }
    
    var titleColor: UIColor? {
        return MovieDetailsItemAppearance.titleColor
    }
    
    var containerStackAxis: NSLayoutConstraint.Axis {
        return .vertical
    }
    
    init(with movieTitle: String, tagLine: String?) {
        titleText = movieTitle
        detailsText = tagLine
    }
}
