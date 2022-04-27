//
//  NetworkManager.swift
//  ImageFinder
//
//  Created by Mohammed Ibrahim on 26/4/22.
//

import Foundation


//MARK: - Model
struct APIResponse: Decodable {
    let results: [ImageModel]
    
    enum CodingKeys: String, CodingKey {
        case results = "results"
    }
}

//MARK: - Network Manager
struct NetworkManager {
    
    //MARK: - Properties
    typealias networkComletion = (APIResponse?) -> ()
    static let shared = NetworkManager()
    let url = "https://api.unsplash.com/search/photos?page=1&query=office"
    let accessKey = "zybTQUOIaNX8yGwNN48sDLTF0KV_m8s83ESdCWnGsrk"
    static var currentPage = 1
    
    
    //MARK: - Methods
    func perform(search : String, completion : @escaping(networkComletion)){
        if (ViewController.searchKey != search){
            NetworkManager.currentPage = 1
        }
        let seturl = "https://api.unsplash.com/search/photos?page=\(NetworkManager.currentPage)&query=\(search)&client_id=\(accessKey)&per_page=30"
        if let url = URL(string: seturl) {
            let session = URLSession(configuration: .default)
             
            let sessionTask = session.dataTask(with: url) { data, response, error in
                if let safeError = error {
                    print(safeError.localizedDescription)
                    if(safeError.localizedDescription.contains("offline")){
                       if let offlinedata = UserDefaults.standard.data(forKey: search)
                        {
                            if let decodedData = parseJson(for: offlinedata){
                                completion(decodedData)
                            }
                        }
                    }
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
            if(UserDefaults.standard.data(forKey: ViewController.searchKey) == nil){
                UserDefaults.standard.set(data, forKey: ViewController.searchKey)
            }
            return decodedData
        }
        catch {
            print(error)
            return nil
        }
    }
    
}
