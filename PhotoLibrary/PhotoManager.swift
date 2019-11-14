//
//  PhotoManager.swift
//  PhotoLibrary
//
//  Created by hongjuyeon_dev on 2019/11/14.
//  Copyright © 2019 hongjuyeon_dev. All rights reserved.
//

import Foundation
import Photos

struct PhotoManagerNofitication {
    static let contentAdded = Notification.Name("com.hongjuyeon.PhotoLibrary.PhotoManagerContentAdded")
    static let contentUpdated = Notification.Name("com.hongjuyeon.PhotoLibrary.PhotoManagerContentUpdated")
}

class PhotoManager {
    private init () { }
    static let shared = PhotoManager()
    
    private let concurrentPhotoQueue = DispatchQueue(label: "com.hongjuyeon.PhotoLibrary.photoQueue", attributes: .concurrent)
    
    private var unsavedPhotos: [Photo] = []
    
    var photos: [Photo] {
        var photoCopy: [Photo] = []
        concurrentPhotoQueue.sync {
            photoCopy = unsavedPhotos
        }
        return photoCopy
    }
    
    func addPhoto(_ photo: Photo) {
        concurrentPhotoQueue.async(flags: .barrier) { [weak self] in
            guard let self = self else { return }
            self.unsavedPhotos.append(photo)
            DispatchQueue.main.async { [weak self] in
                self?.postContentAddNotification()
            }
        }
    }
    
    private func postContentAddNotification() {
        NotificationCenter.default.post(name: PhotoManagerNofitication.contentAdded, object: nil)
    }
}
