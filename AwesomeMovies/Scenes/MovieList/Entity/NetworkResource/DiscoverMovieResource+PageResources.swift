//
//  DiscoverMovieResource+PageResource.swift
//  AwesomeMovies
//
//  Created by Mustafa Saify on 06/02/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation

extension DiscoverMovieResource: PageResources {
    
    func resourceForPage(_ page: Int) -> DiscoverMovieResource {
        return DiscoverMovieResource(
            baseURL: baseURL,
            apiKey: apiKey,
            minYear: minYear,
            maxYear: maxYear,
            page: page)
    }
    
    func isLastPage(_ totalPages: Int, current: Int) -> Bool {
        return current == totalPages
    }
}
