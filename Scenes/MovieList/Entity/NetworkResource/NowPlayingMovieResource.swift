//
//  MovieResource.swift
//  AwesomeMovies
//
//  Created by Mustafa Saify on 02/02/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation

struct MovieResponse: PagedResponse {
    var items: [Movie]
    var totalPages: Int
}

struct NowPlayingMovieResource {
    let baseURL: URL
    let apiKey: String
    let region: String?
    let page: Int?
}

private extension NowPlayingMovieResource {
    
    var parameters: [String: AnyObject] {
        var param = [String: AnyObject]()
        param["region"] = region as AnyObject?
        param["page"] = page as AnyObject?
        param["api_key"] = apiKey as AnyObject?
        return param
    }
}

extension NowPlayingMovieResource: Resource {
    
    func request() -> URLRequest {
        return URLRequest(baseURL: baseURL,
                          path: "movie/now_playing",
                          parameters: parameters)!
    }
    
    var parse: (Data) throws -> MovieResponse {
        return { data in
            let result =  try JSONDecoder()
                .decode(NowPlayingResults.self, from: data)
            return MovieResponse(items: result.results,
                                totalPages: result.total_pages)
        }
    }
}

private struct NowPlayingResults: Decodable {
    let results: [Movie]
    let total_pages: Int
    
    enum CodingKeys: String, CodingKey {
        case results
        case total_pages
    }
}
