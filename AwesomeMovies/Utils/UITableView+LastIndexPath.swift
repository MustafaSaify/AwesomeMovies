//
//  UITableView+LastIndexPath.swift
//  AwesomeMovies
//
//  Created by Mustafa Saify on 04/02/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    
    func lastItemIndexPath() -> IndexPath? {
        var section = numberOfSections - 1
        while section >= 0 {
            let item = numberOfRows(inSection: section) - 1
            if item >= 0 {
                return IndexPath(item: item, section: section)
            }
            section -= 1
        }
        return nil
    }
}
