//
//  ImageResource.swift
//  AwesomeMovies
//
//  Created by Mustafa Saify on 04/02/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation
import UIKit

struct ImageResource {
    let URL: Foundation.URL
}

extension ImageResource: Resource {
    
    func request() -> URLRequest {
        return URLRequest(url: URL)
    }
    
    var parse: (Data) throws -> UIImage? {
        return { data in
            UIImage(data: data)
        }
    }
}
