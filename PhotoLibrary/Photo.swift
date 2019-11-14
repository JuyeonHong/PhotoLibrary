//
//  Photo.swift
//  PhotoLibrary
//
//  Created by hongjuyeon_dev on 2019/11/14.
//  Copyright © 2019 hongjuyeon_dev. All rights reserved.
//

import UIKit
import Photos

protocol Photo {
    var image: UIImage? { get }
    var thumbnailImage: UIImage? { get }
}

private let scale = UIScreen.main.scale
private let imageManager = PHImageManager()
private let cellSize = CGSize(width: 64, height: 64)
private let thumbnailSize = CGSize(width: cellSize.width * scale, height: cellSize.height * scale)

class PhotoAsset: Photo {
    var image: UIImage?
    var thumbnailImage: UIImage?
    
    let asset: PHAsset
    let representedAssetIdentifier: String
    private let targetSize: CGSize = CGSize(width: 600, height: 600)
    
    init(asset: PHAsset) {
        self.asset = asset
        representedAssetIdentifier = asset.localIdentifier
        fetchThumbnailImage()
        fetchImage()
    }
    
    private func fetchThumbnailImage() {
        let options = PHImageRequestOptions()
        options.isNetworkAccessAllowed = true
        imageManager.requestImage(for: asset,
                                  targetSize: thumbnailSize,
                                  contentMode: .aspectFill,
                                  options: options,
                                  resultHandler: { image, info in
                                    if let image = image {
                                        if self.representedAssetIdentifier == self.asset.localIdentifier {
                                            self.thumbnailImage = image
                                        }
                                    }
        })
    }
    
    private func fetchImage() {
        let options = PHImageRequestOptions()
        options.deliveryMode = .highQualityFormat
        options.isNetworkAccessAllowed = true
        
        PHImageManager.default().requestImage(for: asset,
                                              targetSize: targetSize,
                                              contentMode: .aspectFill,
                                              options: options,
                                              resultHandler: { image, info in
                                                if let image = image {
                                                    if image.size.width < self.targetSize.width / 2 {
                                                        DispatchQueue.main.asyncAfter(deadline: .now(), execute: { self.fetchImage() })
                                                    }
                                                    if self.representedAssetIdentifier == self.asset.localIdentifier { self.image = image }
                                                }
        })
    }
}
