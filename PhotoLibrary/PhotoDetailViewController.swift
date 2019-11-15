//
//  PhotoDetailViewController.swift
//  PhotoLibrary
//
//  Created by hongjuyeon_dev on 2019/11/08.
//  Copyright © 2019 hongjuyeon_dev. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assert(imageView != nil, "Image not set !")
        imageView.image = image
        
        // Resize if neccessary to ensure it's not pixelated
        if image.size.height <= imageView.bounds.size.height &&
          image.size.width <= imageView.bounds.size.width {
          imageView.contentMode = .center
        }
    }

}
