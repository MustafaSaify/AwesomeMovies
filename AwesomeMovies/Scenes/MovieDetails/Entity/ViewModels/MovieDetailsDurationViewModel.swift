//
//  MovieDetailsDurationViewModel.swift
//  AwesomeMovies
//
//  Created by Mustafa Saify on 05/02/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation
import UIKit

struct MovieDetailsDurationViewModel: MovieDetailsListable {
    
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
    
    init(with duration: TimeInterval?) {
        titleText = "Duration"
        
        guard let durationInMins = duration else {
            detailsText = nil
            return
        }
        let durationInSecs = durationInMins * 60
        let hours = Int(durationInSecs) / 3600
        let minutes = Int(durationInSecs) / 60 % 60
        var durationString = ""
        if (hours > 0) { durationString.append("\(hours)h") }
        if (minutes > 0) {
            if !durationString.isEmpty { durationString += " " }
            durationString.append("\(minutes)m")
        }
        detailsText = durationString
    }
}
