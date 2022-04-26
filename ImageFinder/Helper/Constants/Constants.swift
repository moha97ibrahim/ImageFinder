//
//  Constants.swift
//  ImageFinder
//
//  Created by Mohammed Ibrahim on 26/4/22.
//

import Foundation
import UIKit


struct Constant {
    static let cellIdentifier = "Reuse Identifier"
    static let two = 2.0
    static let three = 3.0
    static let four = 4.0
    static let inset: CGFloat = 10
    static let minimumLineSpacing: CGFloat = 10
    static let minimumInteritemSpacing: CGFloat = 10
    static let cellsPerRow = two
    static let clientID = "zybTQUOIaNX8yGwNN48sDLTF0KV_m8s83ESdCWnGsrk"
    static let itemPerPage = 2
    static let url =  "https://api.unsplash.com/photos/?client_id=\(clientID)&order_by=ORDER&page=\(itemPerPage)"
    static let cellnibName = "ImageCollectionViewCell"
}
