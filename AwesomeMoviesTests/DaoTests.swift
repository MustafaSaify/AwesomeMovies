//
//  DaoTests.swift
//  AwesomeMoviesTests
//
//  Created by Mustafa Saify on 07/02/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import XCTest
@testable import AwesomeMovies

class DaoTests: XCTestCase {
    
    let dao = MovieListServiceDatasource(
        baseURL: URL(string: Bundle.main.apiBaseUrl())!,
        apiKey: Bundle.main.apiKey(),
        cacheTime: 60
    )
    
    func testSingleQuery() {
        
        let expectation = self.expectation(description: "all items retrieved")
        let filter = MovieFilterDetails(minYear: "2016", maxYear: "2018" )
        dao.getMovies(for: filter, page: 1, completion: { (feedResult) in
            if case .success = feedResult {
                expectation.fulfill()
            }
            else {
                XCTFail()
            }
        })
        
        waitForExpectations(timeout: 60, handler: nil)
    }
    
    func testQuietCancelation() {
        
        let filter = MovieFilterDetails(minYear: "2016", maxYear: "2018" )
        dao.getMovies(for: filter, page: 1, completion: { (feedResult) in
            if case .error(let message) = feedResult {
                print(message)
                XCTFail("Cancellation should fail quietly")
            }
        })
        
        testSingleQuery()
    }
    
    func testCachePerformance() {
        
        func loadSingleQuery() {
            let expectation = self.expectation(description: "random request loaded")
            let filter = MovieFilterDetails(minYear: "2016", maxYear: "2018" )
            dao.getMovies(for: filter, page: 1, completion: { result in
                if case .success = result {
                    expectation.fulfill()
                }
            })
            waitForExpectations(timeout: 60, handler: nil)
        }
        
        loadSingleQuery()
    
        measure {
            loadSingleQuery()
        }
    }
}
