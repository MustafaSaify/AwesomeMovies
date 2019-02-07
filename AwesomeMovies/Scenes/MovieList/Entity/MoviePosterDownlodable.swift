//
//  MoviePosterDownlodable.swift
//  AwesomeMovies
//
//  Created by Mustafa Saify on 05/02/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation
import UIKit

enum PosterSize: String {
    case w500
}

protocol MoviePosterDownlodable: class {
    
    var imageAccess: ImageAccess? { get set }
    var posterPath: String? { get }
    var posterSize: PosterSize { get }
    var posterImage: UIImage? { get set }
    var imageCancellation: (() -> Void)? { get set }
}

extension MoviePosterDownlodable {
    
    var posrterURL: URL? {
        guard let posterPath = posterPath else { return nil }
        let postBaseURL = Bundle.main.posterBaseUrl()
        return URL(string: "\(postBaseURL)\(posterSize.rawValue)/\(posterPath)")
    }
    
    func download(completion: @escaping ((_ image: UIImage?) -> Void)) {
        guard let posterUrl = posrterURL else {
            completion(nil)
            return
        }
        imageCancellation = imageAccess?.imageWithURL(posterUrl) { (image) in
            completion(image)
        }
    }
    
    func cancelImageDownload() {
        imageCancellation?()
    }
}
