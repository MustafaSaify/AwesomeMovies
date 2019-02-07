//
//  ImageAccess.swift
//  AwesomeMovies
//
//  Created by Mustafa Saify on 04/02/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation

import Foundation
import UIKit

typealias CancelImageLoading = () -> Void

protocol ImageAccess {
    
    func imageWithURL(_ URL: URL, completion: @escaping (UIImage?) -> Void) -> CancelImageLoading
}
