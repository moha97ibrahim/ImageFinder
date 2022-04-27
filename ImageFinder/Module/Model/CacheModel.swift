//
//  CacheModel.swift
//  ImageFinder
//
//  Created by Mohammed Ibrahim on 27/4/22.
//

import Foundation


struct CacheModel{
    let title : String
    let url : String
    let search : String
    
    init(title: String, url : String, search : String){
        self.title = title
        self.url = url
        self.search = search
    }
}
