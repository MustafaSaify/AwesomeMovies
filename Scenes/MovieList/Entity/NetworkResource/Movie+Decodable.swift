//
//  Movie+Decodable.swift
//  AwesomeMovies
//
//  Created by Mustafa Saify on 02/02/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation

extension Movie: Decodable {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        posterPath = try container.decode(String.self, forKey: .poster_path)
    }
    
    enum CodingKeys: String, CodingKey {
        case id, title, poster_path, farm, secret
    }
}
