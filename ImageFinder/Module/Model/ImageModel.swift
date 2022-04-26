//
//  ImageModel.swift
//  ImageFinder
//
//  Created by Mohammed Ibrahim on 26/4/22.
//

import Foundation
import UIKit

public struct ImageModel : Codable {

    public let id: String
    public let urls : Urls
}

public struct Urls : Codable {
    public let raw : String
}
