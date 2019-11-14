//
//  PhotoCollectionViewCell.swift
//  PhotoLibrary
//
//  Created by hongjuyeon_dev on 2019/11/08.
//  Copyright © 2019 hongjuyeon_dev. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    var representedAssetIdentifier: String?
    var thumbnailImage: UIImage? {
        didSet {
            imageView.image = thumbnailImage
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
}
