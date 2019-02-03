//
//  MovieDataManager.swift
//  AwesomeMovies
//
//  Created by Mustafa Saify on 02/02/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation

struct MovieDataManager<DataStoreType: Datasource> where DataStoreType.DataType == Movie {
    private let dataSource: DataStoreType
    
    init(dataSource: DataStoreType) {
        self.dataSource = dataSource
    }
    
    func fetchFeeds(for filter: MovieFilter, completion: @escaping ([Movie]) -> ()) {
        dataSource.getFeeds(for: filter) { (feeds: [Movie]) in
            completion(feeds)
        }
    }
}
