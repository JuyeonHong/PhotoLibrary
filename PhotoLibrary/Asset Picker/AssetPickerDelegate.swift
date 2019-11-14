//
//  AssetPickerDelegate.swift
//  PhotoLibrary
//
//  Created by hongjuyeon_dev on 2019/11/14.
//  Copyright © 2019 hongjuyeon_dev. All rights reserved.
//

import Foundation
import Photos

protocol AssetPickerDelegate: class {
    func assetPickerDidFinishPickingAssets(_ selectedAssets: [PHAsset])
}
