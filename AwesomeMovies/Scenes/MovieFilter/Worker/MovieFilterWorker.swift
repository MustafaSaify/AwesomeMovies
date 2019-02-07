//
//  MovieFilterWorker.swift
//  AwesomeMovies
//
//  Created by Mustafa Saify on 06/02/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation

class MovieFilterWorker {
    
    func pickerValues() -> [String] {
        var years = [String]()
        let df = DateFormatter()
        df.dateFormat = "yyyy"
        let currentYear = Int(df.string(from: Date()))!
        for i in (1970...currentYear).reversed() {
            years.append("\(i)")
        }
        return years
    }
    
    func validate(maxYear: String?, minYear: String?) -> Bool {
        guard let maxYear = maxYear, let minYear = minYear else { return true }
        let max = Int(maxYear) ?? 0
        let min = Int(minYear) ?? 0
        return min <= max
    }
}
