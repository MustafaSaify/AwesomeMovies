//
//  MovieListFooterView.swift
//  AwesomeMovies
//
//  Created by Mustafa Saify on 04/02/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import UIKit

class MovieListFooterView: UITableViewHeaderFooterView {
    
    @IBOutlet fileprivate weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet fileprivate weak var theEndLabel: UILabel!
    @IBOutlet fileprivate weak var tryAgainButton: UIButton!
    
    var tryAgainBlock: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with viewModel: MovieListFooterViewModel) {
        theEndLabel.isHidden = !viewModel.showTheEnd
        tryAgainButton.isHidden = !viewModel.showError
        tryAgainButton.setTitle(viewModel.errorText, for: .normal)
        viewModel.showLoader ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
    }
}

//class ItemsCollectionBottomReusableView: UICollectionReusableView {
//
//
//}

//private extension ItemsCollectionBottomReusableView {
//
//    @IBAction func tryAgainTapped() {
//        tryAgainBlock?()
//    }
//
//    func tryAgainAttributedTitleWithMessage(_ message: String, font: UIFont) -> NSAttributedString {
//        let mutableString = NSMutableAttributedString(
//            string: message,
//            attributes: [.font: font, .foregroundColor: UIColor.myGreyColor()])
//        mutableString.append(NSAttributedString(
//            string: " Try again.",
//            attributes: [.font: font, .foregroundColor: UIColor.myRedColor()])
//        )
//        return mutableString
//    }
//}
