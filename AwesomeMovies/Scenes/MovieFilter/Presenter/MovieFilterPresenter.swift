//
//  MovieFilterPresenter.swift
//  AwesomeMovies
//
//  Created by Mustafa Saify on 06/02/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation

protocol MovieFilterPresenterInput {
    func presentFilterItems(response: MovieFilter.List.Response)
    func presentPicker(response: MovieFilter.Pick.Response)
    func presentRecordedItem(response: MovieFilter.Record.Response)
}

protocol MovieFilterPresenterOutput {
    func displayFilterItems(viewModel: MovieFilter.List.ViewModel)
    func displayPicker(viewModel: MovieFilter.Pick.ViewModel)
    func displayRecordedItem(viewModel: MovieFilter.Record.ViewModel)
}

class MovieFilterPresenter: MovieFilterPresenterInput {
    
    var output: MovieFilterPresenterOutput!
    
    func presentFilterItems(response: MovieFilter.List.Response) {
        let items = FilterItem.all
        let viewModels = items.map { filterItemViewModel(for: $0, filterDetails: response.filterDetails) }
        output.displayFilterItems(viewModel: MovieFilter.List.ViewModel(items: viewModels))
    }
    
    func presentPicker(response: MovieFilter.Pick.Response) {
        output.displayPicker(viewModel: MovieFilter.Pick.ViewModel(item: response.item,
                                                                   pickerItems: response.pickerItems,
                                                                   selectedIndex: response.selectedIndex))
    }
    
    func presentRecordedItem(response: MovieFilter.Record.Response) {
        if let error = response.error {
            output.displayRecordedItem(viewModel: MovieFilter.Record.ViewModel(item: response.item,
                                                                               recordedValue: nil,
                                                                               error: error.message))
        }
        else {
            output.displayRecordedItem(viewModel: MovieFilter.Record.ViewModel(item: response.item,
                                                                               recordedValue: response.recordedValue,
                                                                               error: nil))
        }
    }
}

extension MovieFilterPresenter {
    
    fileprivate func filterItemViewModel(for item: FilterItem, filterDetails: MovieFilterDetails) -> MovieFilterItemViewModel {
        let value = item == .maxYear ? filterDetails.maxYear : filterDetails.minYear
        return MovieFilterItemViewModel(for: item, value: value)
    }
}
