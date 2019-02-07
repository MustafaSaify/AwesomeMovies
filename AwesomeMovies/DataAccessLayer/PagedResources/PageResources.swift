//
//  PagedResources.swift
//  AwesomeMovies
//
//  Created by Mustafa Saify on 02/02/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation

protocol PageResponse {
    associatedtype Item
    var items: [Item] { get set }
    var totalPages: Int { get set }
}

protocol PageResources where PageResource: Resource, PageResource.ParsedObject: PageResponse {
    
    associatedtype PageResource
    
    func resourceForPage(_ page: Int) -> PageResource
    
    func isLastPage(_ totalPages: Int, current: Int) -> Bool
}
