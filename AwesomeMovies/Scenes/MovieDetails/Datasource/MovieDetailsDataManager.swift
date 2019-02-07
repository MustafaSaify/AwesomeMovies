//
//  MovieDetailsDataManager.swift
//  AwesomeMovies
//
//  Created by Mustafa Saify on 05/02/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation

struct MovieDetailsDataManager<DataStoreType: MovieDetailsDatasource> where DataStoreType.DataType == MovieDetails {
    private let dataSource: DataStoreType
    
    init(dataSource: DataStoreType) {
        self.dataSource = dataSource
    }
    
    func getDetails(for movieId: Int, completion: @escaping (SynchronizerResult<DataStoreType.DataType>) -> Void) {
        dataSource.getDetails(for: movieId, completion: completion)
    }
}
