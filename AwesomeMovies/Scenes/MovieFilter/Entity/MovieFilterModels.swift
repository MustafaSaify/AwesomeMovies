//
//  MovieFilterModel.swift
//  AwesomeMovies
//
//  Created by Mustafa Saify on 06/02/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation

enum FilterItem {
    case minYear
    case maxYear
    
    var title: String {
        switch self {
        case .minYear:
            return "Minimum Year"
        case .maxYear:
            return "Maximum Year"
        }
    }
    
    static var all: [FilterItem] = [.minYear, .maxYear]
}

enum MovieFilterError: Error {
    case invalidMinYear
    
    var message: String {
        return "The minimum year can't be greater then maximum year. Please check and try again"
    }
}

enum MovieFilter {
    
    enum List {
        
        struct Response {
            var filterDetails: MovieFilterDetails
        }
        
        struct ViewModel {
            var items: [MovieFilterItemViewModel]
        }
    }
    
    enum Pick {
        
        struct Request {
            var item: FilterItem
        }
        
        struct Response {
            var item: FilterItem
            var pickerItems: [String]
            var selectedIndex: Int?
        }
        
        struct ViewModel {
            var item: FilterItem
            var pickerItems: [String]
            var selectedIndex: Int?
        }
    }
    
    enum Record {
        
        struct Request {
            var item: FilterItem
            var value: String?
        }
        
        struct Response {
            var item: FilterItem
            var recordedValue: String?
            var error: MovieFilterError?
        }
        
        struct ViewModel {
            var item: FilterItem
            var recordedValue: String?
            var error: String?
        }
    }
}
