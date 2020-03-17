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

enum ReuseIdentifier {
    
    static let photosCell = "photosCell"
    
}

class PhotosDataSource: NSObject, UICollectionViewDataSource {
    
    private var allPhotos: PHFetchResult<PHAsset>!
    private let imageManager = PHCachingImageManager()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reuseIdentifier = ReuseIdentifier.photosCell
        let photoCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCell
        
        let asset = allPhotos.object(at: indexPath.item)
        imageManager.requestImage(for: asset, targetSize: Size.photoSize, contentMode: .aspectFill, options: nil, resultHandler: { image, _ in
            photoCell.photoImageView.image = image
        })
        return photoCell
    }
    
    func setupPhotos() {
        requestPhotos()
        startCachingImages()
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
    
    func sharePhotoLibraryChanges() {
        PHPhotoLibrary.shared().register(self)
    }

}
