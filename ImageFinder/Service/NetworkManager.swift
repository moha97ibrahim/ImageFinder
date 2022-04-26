//
//  NetworkManager.swift
//  ImageFinder
//
//  Created by Mohammed Ibrahim on 26/4/22.
//

import Foundation


struct NetworkManager {
    static let shared = NetworkManager()
    
    func fetchrequest() {
        perform(url: Constant.url)
    }
    
    func perform(url : String){
        if let url = URL(string: url) {
            let session = URLSession(configuration: .default)
            
            let sessionTask = session.dataTask(with: url) { data, response, error in
                if let safeError = error {
                    print(safeError.localizedDescription)
                    return
                }
                
                if let safeData = data {
                    if let decodedData = parseJson(for: safeData){
                        print(decodedData)
                    }
                }
            }
            sessionTask.resume()
        }
    }
    
    func parseJson(for data : Data) -> [ImageModel]?{
        let decode = JSONDecoder()
        
        do{
            let decodedData =  try decode.decode([ImageModel].self, from: data)
            return decodedData
        }
        catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
}
