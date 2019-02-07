//
//  MovieDataManager.swift
//  AwesomeMovies
//
//  Created by Mustafa Saify on 02/02/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation

struct MovieListDataManager<DataStoreType: MovieListDatasource> where DataStoreType.DataType == Movie {
    private let dataSource: DataStoreType
    
    init(dataSource: DataStoreType) {
        self.dataSource = dataSource
    }
    
    func fetchMovies(for filter: MovieFilterDetails, page: Int?, completion: @escaping (FeedResult<[DataStoreType.DataType]>) -> Void) {
        dataSource.getMovies(for: filter, page: page, completion: completion)
    }
}
