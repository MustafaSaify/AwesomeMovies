//
//  MovieListFooterViewModel.swift
//  AwesomeMovies
//
//  Created by Mustafa Saify on 04/02/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import UIKit

struct MovieListFooterViewModel {
    
    enum State {
        case idle
        case inProgress
        case theEnd
        case tryAgain(message: String)
    }
    
    var state: State = .idle
    
    var showLoader: Bool {
        switch state {
        case .inProgress:
            return true
        default:
            return false
        }
    }
    
    var showTheEnd: Bool {
        switch state {
        case .theEnd:
            return true
        default:
            return false
        }
    }
    
    var showError: Bool {
        switch state {
        case .tryAgain:
            return true
        default:
            return false
        }
    }
    
    var errorText: String? {
        switch state {
        case .tryAgain(let message):
            return message
        default:
            return nil
        }
    }
    
    init(loadingState: LoadingItemState<[Movie]>) {
        switch loadingState {
        case .loading:
            state = .inProgress
        case .succeed, .idle:
            state = .idle
        case .ended:
            state = .theEnd
        case .failed(let error):
            state = .tryAgain(message: error.message)
        }
    }
}
