//
//  ImageViewModel.swift
//  ImageFinder
//
//  Created by Mohammed Ibrahim on 26/4/22.
//

import Foundation
import UIKit

public class ImageViewModel {
    static let shared = ImageViewModel()
    var selctedColumn : Box<Int> = Box(2)
    var fetchedData : Box<APIResponse?> = Box(nil)
    var networkManager = NetworkManager()
    
    init(networkManager : NetworkManager = NetworkManager()){
        self.networkManager = networkManager
    }
    
    func selectedColumnOption(column : String){
        switch column {
            case "two":
            selctedColumn.value = 2
        case "three":
            selctedColumn.value = 3
        case "four":
            selctedColumn.value = 4
        default :
            selctedColumn.value = 2
        }
    }
    
    func getImages(_ search:String) {
        NetworkManager.shared.perform(search: search) {  [unowned self] data in
            guard
                let data = data
            else {
                return
            }
            self.fetchedData.value = data
        }
    }
}


