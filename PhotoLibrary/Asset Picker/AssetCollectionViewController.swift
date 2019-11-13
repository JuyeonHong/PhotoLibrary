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
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var selectedAssets: SelectedAssets?
    var assetsFetchResults: PHFetchResult<AnyObject>?
    
    private var thumbnailSize = CGSize.zero
    private let imageManager = PHImageManager()
    
    private var doneButton: UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.allowsMultipleSelection = true
        
        doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(donePressed(_:)))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // determine the size of the thumbnails to request from the PHCahingImageManager
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let scale = UIScreen.main.scale
            let cellSize = layout.itemSize
            thumbnailSize = CGSize(width: cellSize.width * scale, height: cellSize.height * scale)
        }
        
        collectionView.reloadData()
        updateSelectedItems()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView.reloadData()
        updateSelectedItems()
    }
    
    @objc func donePressed(_ sender: UIBarButtonItem) {
        // delegate that asset picker finish select picking assets
    }
    
}

extension AssetCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let assets = assetsFetchResults else {
            return 0
        }
        return assets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AssetCell", for: indexPath) as! AssetCollectionViewCell
        
        if let fetchResult = assetsFetchResults,
            let asset = fetchResult[indexPath.item] as? PHAsset {
            let options = PHImageRequestOptions()
            options.isNetworkAccessAllowed = true // 꼭 필요한진 모르겠음
            
            cell.representedAssetIdentifier = asset.localIdentifier
            imageManager.requestImage(for: asset,
                                      targetSize: thumbnailSize,
                                      contentMode: .aspectFill,
                                      options: options) { image, _ in
                                        if cell.representedAssetIdentifier == asset.localIdentifier {
                                            cell.thumbnailImage = image
                                        }
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let asset = assetsFetchResults?[indexPath.item] as? PHAsset {
            selectedAssets?.assets.append(asset)
            updateDoneButton()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let assetToDelete = assetsFetchResults?[indexPath.item] as? PHAsset {
            selectedAssets?.assets = (selectedAssets?.assets.filter { !($0 == assetToDelete) })!
            if assetsFetchResults == nil {
                collectionView.deleteItems(at: [indexPath])
            }
            updateDoneButton()
        }
    }
}

extension AssetCollectionViewController {
    private func updateSelectedItems() {
      guard selectedAssets != nil else { return }
      // Select the selected items
      if let fetchResult = assetsFetchResults {
        for asset in selectedAssets!.assets {
          let index = fetchResult.index(of: asset)
          if index != NSNotFound {
            let indexPath = IndexPath(item: index, section: 0)
            collectionView!.selectItem(at: indexPath,
                                       animated: false, scrollPosition: UICollectionView.ScrollPosition())
          }
        }
      } else {
        for i in 0..<selectedAssets!.assets.count {
          let indexPath = IndexPath(item: i, section: 0)
          collectionView!.selectItem(at: indexPath,
                                     animated: false, scrollPosition: UICollectionView.ScrollPosition())
        }
      }
      updateDoneButton()
    }
    
    private func updateDoneButton() {
      guard selectedAssets != nil else { return }
      // Add a done button when there are selected assets
        if (selectedAssets?.assets.count)! > 0 {
        navigationItem.rightBarButtonItem = doneButton
      } else {
        navigationItem.rightBarButtonItem = nil
      }
    }
}
