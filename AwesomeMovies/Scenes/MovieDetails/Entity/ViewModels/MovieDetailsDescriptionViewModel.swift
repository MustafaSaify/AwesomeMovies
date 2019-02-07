//
//  MovieDetailsDescriptionViewModel.swift
//  AwesomeMovies
//
//  Created by Mustafa Saify on 05/02/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation
import UIKit

struct MovieDetailsDescriptionViewModel: MovieDetailsListable {
    
    var titleText: String?
    
    var detailsText: String?
    
    var titleFont: UIFont? {
        return nil
    }
    
    var titleColor: UIColor? {
        return nil
    }
    
    var containerStackAxis: NSLayoutConstraint.Axis {
        return .vertical
    }
    
    init(with description: String?) {
        detailsText = description
    }
}
