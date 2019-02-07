//
//  MovieDetailsPosterViewModel.swift
//  AwesomeMovies
//
//  Created by Mustafa Saify on 05/02/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation
import UIKit

class MovieDetailsPosterViewModel: MoviePosterDownlodable {
    
    var imageAccess: ImageAccess?
    
    var posterPath: String?
    
    var posterSize: PosterSize {
        return .w500
    }
    
    var posterImage: UIImage?
    
    var imageCancellation: (() -> Void)?
    
    init?(with posterPath: String?, imageAccess: ImageAccess?) {
        guard let path = posterPath else { return nil }
        self.posterPath = path
        self.imageAccess = imageAccess
    }
    
    func downloadPoster(onCompletion: @escaping ((_ image: UIImage?) -> Void)) {
        download { [weak self] (image) in
            self?.posterImage = image
            onCompletion(image)
        }
    }
    
    deinit {
        imageCancellation?()
    }
    
}
