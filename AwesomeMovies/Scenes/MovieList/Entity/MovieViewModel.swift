//
//  MovieViewModel.swift
//  AwesomeMovies
//
//  Created by Mustafa Saify on 02/02/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class MovieViewModel: MoviePosterDownlodable {
    
    var dataModel: Movie
    
    var imageAccess: ImageAccess?
    
    var posterPath: String? {
        return dataModel.posterPath
    }
    
    var posterSize: PosterSize {
        return .w500
    }
    
    var imageCancellation: (() -> Void)?
    
    fileprivate var posterImageSubject = BehaviorRelay<UIImage?>(value: nil)
    
    var posterImage: UIImage? {
        get {
            return posterImageSubject.value
        }
        set {
            assertionFailure("The poster image isn't supposed to be initialized")
        }
    }
    
    var title: String {
        return dataModel.title
    }
    
    var releaseDateText: String? {
        guard let releaseDate = dataModel.releaseDate else { return nil }
        let df = DateFormatter()
        df.dateFormat = "MMMM dd, yyyy"
        return "Released on \(df.string(from: releaseDate))" 
    }
    
    init(with dataModel: Movie, imageDownloader: ImageAccess?) {
        self.dataModel = dataModel
        self.imageAccess = imageDownloader
    }
    
    func downloadPoster() {
        download { [weak self] (image) in
            self?.posterImageSubject.accept(image)
        }
    }
    
    func cancelImageDownload() {
        imageCancellation?()
    }
}

extension MovieViewModel {
    
    func rxPosterImage() -> Observable<UIImage?> {
        return posterImageSubject.asObservable()
    }
}


