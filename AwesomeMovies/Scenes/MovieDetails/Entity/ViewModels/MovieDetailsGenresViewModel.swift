//
//  MovieDetailsGenresViewModel.swift
//  AwesomeMovies
//
//  Created by Mustafa Saify on 05/02/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation
import UIKit

struct MovieDetailsGenresViewModel: MovieDetailsListable {
    
    var titleText: String?
    
    var detailsText: String?
    
    var titleFont: UIFont? {
        return MovieDetailsItemAppearance.titleFont
    }
    
    var titleColor: UIColor? {
        return MovieDetailsItemAppearance.titleColor
    }
    
    var containerStackAxis: NSLayoutConstraint.Axis {
        return .horizontal
    }
    
    init(with genres: [Genre]) {
        titleText = "Genres"
        detailsText = genres.map{ $0.name }.joined(separator: " | ")
    }
}
