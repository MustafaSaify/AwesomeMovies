//
//  URLRequest+Convenience.swift
//  AwesomeMovies
//
//  Created by Mustafa Saify on 02/02/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation

extension URLRequest {
    
    init?(baseURL: URL, path: String?, parameters: [String: AnyObject]?) {
        let URL = baseURL.appendingPathComponent(path ?? "")
        var components = URLComponents(url: URL, resolvingAgainstBaseURL: false)
        
        components?.queryItems = parameters?.map { key, value -> URLQueryItem in
            URLQueryItem(name: String(key), value: String(describing: value))
        }
        
        guard let componentsURL = components?.url else {
            return nil
        }
        self.init(url: componentsURL)
    }
}
