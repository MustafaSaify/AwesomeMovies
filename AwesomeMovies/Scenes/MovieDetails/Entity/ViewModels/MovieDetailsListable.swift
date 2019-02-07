//
//  MovieDetailsListable.swift
//  AwesomeMovies
//
//  Created by Mustafa Saify on 05/02/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation
import UIKit

protocol MovieDetailsListable {
    var titleText: String? { get set }
    var detailsText: String? { get set }
    
    var titleFont: UIFont? { get }
    var titleColor: UIColor? { get }
    
    var detailsFont: UIFont? { get }
    var detailsColor: UIColor? { get }
    var detailsTextAlignment: NSTextAlignment { get }
    
    var containerStackAxis: NSLayoutConstraint.Axis { get }
}

extension MovieDetailsListable {
    
    var detailsFont: UIFont? {
        return MovieDetailsItemAppearance.detailsFont
    }
    
    var detailsColor: UIColor? {
        return MovieDetailsItemAppearance.detailsColor
    }
    
    var detailsTextAlignment: NSTextAlignment {
        return containerStackAxis == .horizontal ? .right : .left
    }
}

struct MovieDetailsItemAppearance {
    
    static var titleFont: UIFont {
        return UIFont.boldSystemFont(ofSize: 15.0)
    }
    
    static var detailsFont: UIFont {
        return UIFont.systemFont(ofSize: 15.0)
    }
    
    static var titleColor: UIColor {
        return .black
    }
    
    static var detailsColor: UIColor {
        return .black
    }
}
