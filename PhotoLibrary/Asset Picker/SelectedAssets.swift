//
//  SelectedAssets.swift
//  PhotoLibrary
//
//  Created by hongjuyeon_dev on 2019/11/11.
//  Copyright © 2019 hongjuyeon_dev. All rights reserved.
//

import Foundation
import Photos

class SelectedAssets: NSObject {
    // PHAsset: an image, video, or Live Photo in the Photos library
    var assets: [PHAsset]
    
    override init() {
        assets = []
    }
    
    init(assets: [PHAsset]) {
        self.assets = assets
    }
}
