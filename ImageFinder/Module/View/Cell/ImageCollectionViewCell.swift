//
//  ImageCollectionViewCell.swift
//  ImageFinder
//
//  Created by Mohammed Ibrahim on 26/4/22.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView = nil
    }

}
