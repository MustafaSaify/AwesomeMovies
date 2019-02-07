//
//  MovieDetailsResource.swift
//  AwesomeMovies
//
//  Created by Mustafa Saify on 05/02/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation

struct MovieDetailsResource {
    let baseURL: URL
    let apiKey: String
    let movieId: Int
}

private extension MovieDetailsResource {
    
    var parameters: [String: AnyObject] {
        var param = [String: AnyObject]()
        param["api_key"] = apiKey as AnyObject?
        return param
    }
}

extension MovieDetailsResource: Resource {
    
    func request() -> URLRequest {
        return URLRequest(baseURL: baseURL,
                          path: "movie/\(movieId)",
                          parameters: parameters)!
    }
    
    var parse: (Data) throws -> MovieDetails {
        return { data in
            return try JSONDecoder()
                .decode(MovieDetails.self, from: data)
        }
    }
}
