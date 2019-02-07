//
//  DiscoverMovieResource.swift
//  AwesomeMovies
//
//  Created by Mustafa Saify on 06/02/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation

struct DiscoverMovieResponse: PageResponse {
    var items: [Movie]
    var totalPages: Int
}

struct DiscoverMovieResource {
    let baseURL: URL
    let apiKey: String
    let minYear: String?
    let maxYear: String?
    let page: Int?
}

private extension DiscoverMovieResource {
    
    var parameters: [String: AnyObject] {
        
        var primaryReleaseDateGTE: String?
        var primaryReleaseDateLTE: String?
        if let minYear = minYear {
            primaryReleaseDateGTE = "\(minYear)-01-01"
        }
        if let maxYear = maxYear {
            primaryReleaseDateLTE = "\(maxYear)-12-31"
        }
        
        var param = [String: AnyObject]()
        param["page"] = page as AnyObject?
        param["api_key"] = apiKey as AnyObject?
        param["primary_release_date.gte"] = primaryReleaseDateGTE as AnyObject?
        param["primary_release_date.lte"] = primaryReleaseDateLTE as AnyObject?
        param["sort_by"] = "popularity.desc" as AnyObject?
        return param
    }
}

extension DiscoverMovieResource: Resource {
    
    func request() -> URLRequest {
        return URLRequest(baseURL: baseURL,
                          path: "discover/movie",
                          parameters: parameters)!
    }
    
    var parse: (Data) throws -> DiscoverMovieResponse {
        return { data in
            let result =  try JSONDecoder()
                .decode(DiscoverMovieResults.self, from: data)
            return DiscoverMovieResponse(items: result.results,
                                 totalPages: result.total_pages)
        }
    }
}

private struct DiscoverMovieResults: Decodable {
    let results: [Movie]
    let total_pages: Int
    
    enum CodingKeys: String, CodingKey {
        case results
        case total_pages
    }
}
