//
//  MovieFilterItemViewModel.swift
//  AwesomeMovies
//
//  Created by Mustafa Saify on 06/02/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation

struct MovieFilterItemViewModel {
    
    var itemType: FilterItem
    var value: String?
    
    var titleText: String {
        return itemType.title
    }
    
    var detailsText: String? {
        return value ?? "Select"
    }
    
    init(for type: FilterItem, value: String?) {
        self.itemType = type
        self.value = value
    }
}
