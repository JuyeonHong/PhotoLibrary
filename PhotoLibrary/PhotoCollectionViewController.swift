//
//  PhotoCollectionViewController.swift
//  PhotoLibrary
//
//  Created by hongjuyeon_dev on 2019/11/08.
//  Copyright © 2019 hongjuyeon_dev. All rights reserved.
//
// ref: https://www.raywenderlich.com/5370-grand-central-dispatch-tutorial-for-swift-4-part-1-2#c-rate

import UIKit
import Photos

class PhotoCollectionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func addPhotoAsset(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Get Photo From", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction.init(title: "Photo Library", style: .default, handler: { _ in
            let navigationController = self.storyboard?.instantiateViewController(identifier: "AlbumsStoryboard") as? UINavigationController
            if let vc = navigationController {
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            }
        }))
        alert.addAction(UIAlertAction.init(title: "cancel", style: .destructive, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension PhotoCollectionViewController: AssetPickerDelegate {
    func assetPickerDidFinishPickingAssets(_ selectedAssets: [PHAsset]) {
        <#code#>
    }
}

extension PhotoCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
}
