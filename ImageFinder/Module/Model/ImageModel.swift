//
//  ImageModel.swift
//  ImageFinder
//
//  Created by Mohammed Ibrahim on 26/4/22.
//

import Foundation
import UIKit

public struct ImageModel : Decodable {
     let urls: PostUrls
}

struct PostUrls: Decodable {
  let regular: String
}
