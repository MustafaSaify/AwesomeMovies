//
//  MovieDetails+Codeable.swift
//  AwesomeMovies
//
//  Created by Mustafa Saify on 05/02/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation

extension MovieDetails: Decodable {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        duration = try? container.decode(TimeInterval.self, forKey: .runtime)
        genres = try container.decode([Genre].self, forKey: .genres)
        posterPath = try? container.decode(String.self, forKey: .poster_path)
        rating = try? container.decode(Float.self, forKey: .vote_average)
        votes = try? container.decode(Int.self, forKey: .vote_count)
        description = try? container.decode(String.self, forKey: .overview)
        tagLine = try? container.decode(String.self, forKey: .tagline)
    }
    
    enum CodingKeys: String, CodingKey {
        case id, title, runtime, genres, poster_path, vote_average, vote_count, overview, tagline
    }
}

extension Genre: Decodable {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name
    }
}
