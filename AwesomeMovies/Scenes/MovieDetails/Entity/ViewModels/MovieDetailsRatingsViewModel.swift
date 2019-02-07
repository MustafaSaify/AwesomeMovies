//
//  MovieDetailsRatingsViewModel.swift
//  AwesomeMovies
//
//  Created by Mustafa Saify on 05/02/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation
import UIKit

struct MovieDetailsRatingsViewModel: MovieDetailsListable {
    
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
    
    init(with ratings: Float?, votesCount: Int?) {
        titleText = "Ratings"
        var ratingText = ""
        if let ratings = ratings {
            ratingText.append("\(ratings)/10")
        }
        if let votes = votesCount {
            ratingText.append(" (\(votes) votes)")
        }
        detailsText = ratingText
    }
}
