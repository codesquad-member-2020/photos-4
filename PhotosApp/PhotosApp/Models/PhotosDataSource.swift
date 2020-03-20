//
//  CollectionViewDataSource.swift
//  PhotosApp
//
//  Created by jinie on 2020/03/16.
//  Copyright © 2020 jinie. All rights reserved.
//

import UIKit
import Photos

class PhotosDataSource: NSObject, UICollectionViewDataSource {
    
    private var userLibraryPhotos: PHFetchResult<PHAsset>!
    private let imageManager = PHCachingImageManager()
    let photosSectionIndex = 0
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return userLibraryPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let photoCell = collectionView.dequeueReusableCell(withReuseIdentifier:
            PhotoCell.reuseIdentifier, for:indexPath) as! PhotoCell
        
        let asset = userLibraryPhotos.object(at: indexPath.item)
        imageManager.requestImage(for: asset,
                                  targetSize: PhotoCell.cellSize,
                                  contentMode: .aspectFill,
                                  options: nil,
                                  resultHandler: { image, _ in
            photoCell.setPhoto(image: image)
        })
        return photoCell
    }
    
}

extension PhotosDataSource {
    
    func isPhotoAuthorized(completion: @escaping (Bool) -> ()) -> Bool {
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthorizationStatus {
        case .authorized:
            return true
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({ status in
                switch status {
                case .authorized:
                    completion(true)
                default:
                    completion(false)
                }
            })
        default:
            return false
        }
        return false
    }
    
    func setupPhotos() {
        requestPhotos()
        startCachingImages()
        sharePhotoLibraryChanges()
    }
    
    private func requestPhotos() {
        let fetchOptions : PHFetchOptions = {
            let fetchOptions = PHFetchOptions()
            let numberOfItems = 40
            fetchOptions.fetchLimit = numberOfItems
            fetchOptions.includeAllBurstAssets = false
            fetchOptions.includeAssetSourceTypes = .typeUserLibrary
            return fetchOptions
        }()
        userLibraryPhotos = PHAsset.fetchAssets(with: .image, options: fetchOptions)
    }
    
    private func startCachingImages() {
        let indexSet = IndexSet(integersIn: 0 ..< userLibraryPhotos.count)
        let assets = userLibraryPhotos.objects(at: indexSet)
        imageManager.startCachingImages(for: assets,
                                        targetSize: PhotoCell.cellSize,
                                        contentMode: .aspectFill,
                                        options: nil)
    }
    
}

extension PhotosDataSource: PHPhotoLibraryChangeObserver {
    
    static let notificationPhotoLibraryDidChange = Notification.Name("photoLibraryDidChange")
    
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        DispatchQueue.main.sync {
            if let changes = changeInstance.changeDetails(for: userLibraryPhotos) {
                userLibraryPhotos = changes.fetchResultAfterChanges
                NotificationCenter.default.post(name: PhotosDataSource
                                                .notificationPhotoLibraryDidChange,
                                                object: self,
                                                userInfo: ["changes" : changes])
            }
        }
    }
    
    private func sharePhotoLibraryChanges() {
        PHPhotoLibrary.shared().register(self)
    }
    
}
