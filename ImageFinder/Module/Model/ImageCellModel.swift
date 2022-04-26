//
//  ImageCellModel.swift
//  ImageFinder
//
//  Created by Mohammed Ibrahim on 26/4/22.
//

import Foundation

struct ImageCellModel {
    let id : String
    let image : Data
    
    init(id: String, image : Data){
        self.id = id
        self.image = image
    }
}
