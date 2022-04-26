//
//  NetworkManager.swift
//  ImageFinder
//
//  Created by Mohammed Ibrahim on 26/4/22.
//

import Foundation


struct APIResponse: Decodable {
    let results: [ImageModel]
    
    enum CodingKeys: String, CodingKey {
        case results = "results"
    }
}

struct NetworkManager {
    typealias networkComletion = (APIResponse?) -> ()
    static let shared = NetworkManager()
    let url = "https://api.unsplash.com/search/photos?page=1&query=office"
    let accessKey = "zybTQUOIaNX8yGwNN48sDLTF0KV_m8s83ESdCWnGsrk"
    
    func perform(search : String, page : Int = 1, completion : @escaping(networkComletion)){
        let seturl = "https://api.unsplash.com/search/photos?page=\(page)&query=\(search)&client_id=\(accessKey)&per_page=30"
        if let url = URL(string: seturl) {
            let session = URLSession(configuration: .default)
             
            let sessionTask = session.dataTask(with: url) { data, response, error in
                if let safeError = error {
                    print(safeError.localizedDescription)
                    return
                }
                
                if let safeData = data {
                    if let decodedData = parseJson(for: safeData){
                        completion(decodedData)
                    }
                }
            }
            sessionTask.resume()
        }
    }
    
    func parseJson(for data : Data) -> APIResponse?{
        let decode = JSONDecoder()
        
        do{
            let decodedData =  try decode.decode(APIResponse.self, from: data)
            return decodedData
        }
        catch {
            print(error)
            return nil
        }
    }
    
}
