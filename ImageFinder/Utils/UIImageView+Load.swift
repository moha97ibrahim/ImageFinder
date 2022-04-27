//
//  UIImageView+Load.swift
//  ImageFinder
//
//  Created by Mohammed Ibrahim on 26/4/22.
//

import Foundation
import UIKit

extension UIImageView {

    private static let imageCache = NSCache<NSString, UIImage>()
    private var imageCache: NSCache<NSString, UIImage> { UIImageView.imageCache }
    
    func imageFromServerURL(_ URLString: String, placeHolder: UIImage?, indicator : UIActivityIndicatorView) {
        self.image = nil
        let imageServerUrl = URLString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        if let cachedImage = imageCache.object(forKey: NSString(string: imageServerUrl)) {
            self.image = cachedImage
            print("loaded from cache")
            indicator.stopAnimating()
            indicator.isHidden = true
            return
        }

        if let url = URL(string: imageServerUrl) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if error != nil {
                    print("ERROR LOADING IMAGES FROM URL: \(String(describing: error))")
                    DispatchQueue.main.async {
                        self.image = placeHolder
                    }
                    return
                }
                DispatchQueue.main.async {
                    if let data = data {
                        if let downloadedImage = UIImage(data: data) {
                            self.imageCache.setObject(downloadedImage, forKey: NSString(string: imageServerUrl))
                            self.image = downloadedImage
                            indicator.stopAnimating()
                            indicator.isHidden = true
                        }
                    }
                }
            }).resume()
        }
    }
}
