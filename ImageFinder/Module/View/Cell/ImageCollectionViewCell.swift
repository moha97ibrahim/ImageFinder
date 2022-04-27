//
//  ImageCollectionViewCell.swift
//  ImageFinder
//
//  Created by Mohammed Ibrahim on 26/4/22.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(url : String){
        activityIndicator.startAnimating()
        imageView.imageFromServerURL(url, placeHolder: nil, indicator: activityIndicator)
    }

}
