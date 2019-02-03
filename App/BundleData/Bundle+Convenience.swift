//
//  Bundle+Convenience.swift
//  AwesomeMovies
//
//  Created by Mustafa Saify on 02/02/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation

extension Bundle {
    
    func apiBaseUrl() -> String {
        return infoValueForKey("BASE_URL_ENDPOINT")!
    }
    
    func apiKey() -> String {
        return infoValueForKey("API_KEY")!
    }
    
    func infoValueForKey<Value>(_ key: String) -> Value? {
        return infoDictionary![key] as? Value
    }
}
