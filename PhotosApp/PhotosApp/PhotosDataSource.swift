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
    
    private var allPhotos: PHFetchResult<PHAsset>!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let numberOfItems = 40
        return numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reuseIdentifier = ReuseIdentifier.photosCell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCell
        return cell
    }
    
    func requestPhotos() {
        allPhotos = PHAsset.fetchAssets(with: .image, options: nil)
    }
    
}

enum ReuseIdentifier {
    
    static let photosCell = "photosCell"
    
}
