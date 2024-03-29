//
//  AlbumTableViewController.swift
//  PhotoLibrary
//
//  Created by hongjuyeon_dev on 2019/11/08.
//  Copyright © 2019 hongjuyeon_dev. All rights reserved.
//

import UIKit
import Photos

enum PHPhotoLibraryAuthorizationError {
    case error(PHAuthorizationStatus)
}

class AlbumTableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var selectedAssets: SelectedAssets?
    private var userLibrary: PHFetchResult<PHAssetCollection>?
    private var userAlbums: PHFetchResult<PHCollection>?

    var assetPickerDelegate: AssetPickerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if selectedAssets == nil {
            selectedAssets = SelectedAssets()
        }
        PHPhotoLibrary.requestAuthorization({ status in
            DispatchQueue.main.async {
                switch status {
                case .authorized:
                    self.fetchCollections()
                    self.tableView.reloadData()
                    break
                default:
                    self.showNoAccessAlert()
                    print(PHPhotoLibraryAuthorizationError.error(status))
                    break
                }
            }
        })
        
    }
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as? AssetCollectionViewController
        destination?.selectedAssets = selectedAssets
        destination?.assetPickerDelegate = self
        
        if let cell = sender as? AlbumTableViewCell {
            destination?.title = cell.title
            
            let options = PHFetchOptions()
            options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
            
            if let indexPath = tableView.indexPath(for: cell) {
                switch indexPath.section {
                // userLibrary
                case 0:
                    let library = userLibrary?[indexPath.row]
                    destination?.assetsFetchResults = PHAsset.fetchAssets(in: library!, options: options) as? PHFetchResult<AnyObject>
                    
                // userAlbums
                case 1:
                    let albums = userAlbums?[indexPath.row] as? PHAssetCollection
                    destination?.assetsFetchResults = PHAsset.fetchAssets(in: albums!, options: options) as? PHFetchResult<AnyObject>
                    
                default:
                    break
                }
            }
        }
    }
    
    @IBAction func cancelBtnClick(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}

extension AlbumTableViewController: AssetPickerDelegate {
    func assetPickerDidFinishPickingAssets(_ selectedAssets: [PHAsset]) {
        assetPickerDelegate?.assetPickerDidFinishPickingAssets(selectedAssets)
        // Clear out selections
        self.selectedAssets?.assets.removeAll()
        self.dismiss(animated: true, completion: nil)
    }
}

extension AlbumTableViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2 // userLibrary, userAlbums
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let library = userLibrary, let album = userAlbums else {
            return 0
        }
        switch section {
        case 0:
            return library.count
        case 1:
            return album.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumsCell", for: indexPath) as! AlbumTableViewCell
        
        switch indexPath.section {
        case 0:
            if let library = userLibrary?[indexPath.row], var title = library.localizedTitle {
                if library.estimatedAssetCount != NSNotFound {
                    title += "\(library.estimatedAssetCount)"
                }
                cell.title = title
            }
        case 1:
            if let album = userAlbums?[indexPath.row] as? PHAssetCollection, var title = album.localizedTitle {
                if album.estimatedAssetCount != NSNotFound {
                    title += "\(album.estimatedAssetCount)"
                }
                cell.title = title
            }
        default:
            break
        }
        
        return cell
    }
}

extension AlbumTableViewController {
    func fetchCollections() {
        userLibrary = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: nil)
        userAlbums = PHCollectionList.fetchTopLevelUserCollections(with: nil)
    }
    
    func showNoAccessAlert() {
        let alert = UIAlertController.init(title: "No Photo Permission", message: "Please grant photo permissions in Settings", preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction.init(title: "Settings", style: .default, handler: { _ in
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
