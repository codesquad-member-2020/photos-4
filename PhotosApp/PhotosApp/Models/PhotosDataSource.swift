//
//  CollectionViewDataSource.swift
//  PhotosApp
//
//  Created by jinie on 2020/03/16.
//  Copyright © 2020 jinie. All rights reserved.
//

import UIKit
import Photos

enum Size {
    
    static let photoSize = CGSize(width: 100, height: 100)
    
}

protocol PhotosDataSourceDelegate {
    
    func allPhotosDidChange(changes: PHFetchResultChangeDetails<PHAsset>)
    
}


class PhotosDataSource: NSObject, UICollectionViewDataSource {
    
    var delegate: PhotosDataSourceDelegate!
    private var allPhotos: PHFetchResult<PHAsset>!
    private let imageManager = PHCachingImageManager()
    let photosSectionIndex = 0
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let photoCell = collectionView.dequeueReusableCell(withReuseIdentifier:
            PhotoCell.reuseIdentifier, for:indexPath) as! PhotoCell
        
        let asset = allPhotos.object(at: indexPath.item)
        imageManager.requestImage(for: asset, targetSize: Size.photoSize, contentMode: .aspectFill, options: nil, resultHandler: { image, _ in
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
        allPhotos = PHAsset.fetchAssets(with: .image, options: nil)
    }
    
    private func startCachingImages() {
        let indexSet = IndexSet(integersIn: 0 ..< allPhotos.count)
        let assets = allPhotos.objects(at: indexSet)
        imageManager.startCachingImages(for: assets,
                                        targetSize: Size.photoSize,
                                        contentMode: .aspectFill,
                                        options: nil)
    }
    
}

extension PhotosDataSource: PHPhotoLibraryChangeObserver {
    
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        DispatchQueue.main.sync {
            if let changes = changeInstance.changeDetails(for: allPhotos) {
                allPhotos = changes.fetchResultAfterChanges
                delegate.allPhotosDidChange(changes: changes)
            }
        }
    }
    
    private func sharePhotoLibraryChanges() {
        PHPhotoLibrary.shared().register(self)
    }

}
