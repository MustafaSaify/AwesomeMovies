//
//  Synchronizer+PageResources.swift
//  AwesomeMovies
//
//  Created by Mustafa Saify on 03/02/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation

extension Synchronizer {
    
    func loadPagedResource<PR: PageResources>(_ resource: PR, completion: @escaping (FeedResult<[PR.PageResource.ParsedObject.Item]>) -> Void) {
        loadPagedResource(resource, page: 1, completion: completion)
    }
    
    fileprivate func loadPagedResource<PR: PageResources>(_ pagedResource: PR, page: Int, completion: @escaping (FeedResult<[PR.PageResource.ParsedObject.Item]>) -> Void) {
        let resource = pagedResource.resourceForPage(page)
        
        _ = loadResource(resource) { synchronizerResult in
            
            switch synchronizerResult {
            case .success(let result):
                if pagedResource.isLastPage(result.totalPages, current: page) {
                    completion(.success(page: result.items, nextPageIfNotLast: nil))
                } else {
                    let nextPage: FeedResult<[PR.PageResource.ParsedObject.Item]>.LoadPageBlock = { [weak self] completion in
                        self?.loadPagedResource(pagedResource, page: page + 1, completion: completion)
                    }
                    completion(.success(page: result.items, nextPageIfNotLast: nextPage))
                }
            case .noData:
                completion(.feedEnd)
            case .error(let err):
                let retry: FeedResult<[PR.PageResource.ParsedObject.Item]>.LoadPageBlock = { [weak self] completion in
                    self?.loadPagedResource(pagedResource, page: page, completion: completion)
                }
                completion(.error(error: err, retry: retry))
            }
        }
    }
}
