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
        posterPath = try? container.decode(String.self, forKey: .poster_path)
        let releaseDate = try? container.decode(String.self, forKey: .release_date)
        if let rDate = releaseDate {
            let df = DateFormatter()
            df.dateFormat = "yyyy-MM-dd"
            self.releaseDate = df.date(from: rDate)
        }
        else { self.releaseDate = nil }
    }
    
    enum CodingKeys: String, CodingKey {
        case id, title, poster_path, release_date
    }
}
