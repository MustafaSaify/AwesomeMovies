
//
//  MovieFilterInteractor.swift
//  AwesomeMovies
//
//  Created by Mustafa Saify on 06/02/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation

protocol MovieFilterInteractorInput {
    func listFilterItems()
    func pick(request: MovieFilter.Pick.Request)
}

protocol MovieFilterInteractorOutput {
    func presentFilterItems(response: MovieFilter.List.Response)
    func presentPicker(response: MovieFilter.Pick.Response)
    func presentRecordedItem(response: MovieFilter.Record.Response)
}

class MovieFilterInteractor: MovieFilterInteractorInput {
    
    var output: MovieFilterInteractorOutput!
    var filterDetails: MovieFilterDetails!
    fileprivate lazy var worker = MovieFilterWorker()
    
    func listFilterItems() {
        output.presentFilterItems(response: MovieFilter.List.Response(filterDetails: filterDetails))
    }
    
    func pick(request: MovieFilter.Pick.Request) {
        let pickerItems = worker.pickerValues()
        let selectedValue = request.item == .minYear ? filterDetails.minYear : filterDetails.maxYear
        let selectedIndex: Int? = selectedValue != nil ? pickerItems.firstIndex(of: selectedValue!) : nil
        output.presentPicker(response: MovieFilter.Pick.Response(item: request.item,
                                                                 pickerItems: pickerItems,
                                                                 selectedIndex: selectedIndex))
    }
    
    func record(request: MovieFilter.Record.Request) {
        let maxValueToValidate = request.item == .maxYear ? request.value : filterDetails.maxYear
        let minValueToValidate = request.item == .minYear ? request.value : filterDetails.minYear
        guard worker.validate(maxYear: maxValueToValidate, minYear: minValueToValidate) else {
            output.presentRecordedItem(response: MovieFilter.Record.Response(item: request.item,
                                                                             recordedValue: nil,
                                                                             error: .invalidMinYear))
            return
        }
        if request.item == .minYear {
            filterDetails.minYear = request.value
        }
        else if request.item == .maxYear {
            filterDetails.maxYear = request.value
        }
        output.presentRecordedItem(response: MovieFilter.Record.Response(item: request.item,
                                                                         recordedValue: request.value,
                                                                         error: nil))
    }
    
    func clearFilter() {
        filterDetails.minYear = nil
        filterDetails.maxYear = nil
        output.presentFilterItems(response: MovieFilter.List.Response(filterDetails: filterDetails))
    }
}
