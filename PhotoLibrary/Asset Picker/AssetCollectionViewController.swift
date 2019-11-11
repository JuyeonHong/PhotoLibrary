//
//  AssetCollectionViewController.swift
//  PhotoLibrary
//
//  Created by hongjuyeon_dev on 2019/11/08.
//  Copyright © 2019 hongjuyeon_dev. All rights reserved.
//

import UIKit
import Photos

class AssetCollectionViewController: UIViewController {

    var selectedAssets: SelectedAssets?
    var assetsFetchResults: PHFetchResult<AnyObject>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
