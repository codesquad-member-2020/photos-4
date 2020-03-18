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


class PhotosDataSource: NSObject, UICollectionViewDataSource {
    
    private var allPhotos: PHFetchResult<PHAsset>!
    private let imageManager = PHCachingImageManager()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let photoCell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.identifier, for: indexPath) as! PhotoCell
        
        let asset = allPhotos.object(at: indexPath.item)
        imageManager.requestImage(for: asset, targetSize: Size.photoSize, contentMode: .aspectFill, options: nil, resultHandler: { image, _ in
            photoCell.setPhoto(image: image)
        })
        return photoCell
    }
    
    func isPhotoAuthorized() -> Bool {
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthorizationStatus {
        case .authorized:
            return true
        case .notDetermined:
            var isAuthorized = false
            PHPhotoLibrary.requestAuthorization({ status in
                switch status {
                case .authorized:
                    isAuthorized = true
                default:
                    isAuthorized = false
                }
            })
            return isAuthorized
        default:
            return false
        }
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
        let changedAllphotos = changeInstance.changeDetails(for: allPhotos)
    }
    
    private func sharePhotoLibraryChanges() {
        PHPhotoLibrary.shared().register(self)
    }

}
