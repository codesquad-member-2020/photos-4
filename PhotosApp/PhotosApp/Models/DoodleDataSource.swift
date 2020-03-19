//
//  DoodleDataSource.swift
//  PhotosApp
//
//  Created by jinie on 2020/03/19.
//  Copyright © 2020 jinie. All rights reserved.
//

import UIKit

class DoodleDataSource: NSObject, UICollectionViewDataSource {
    
    private let doodleImageManager = DoodleImageManager()

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return doodleImageManager.count ?? 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let doodleCell = collectionView.dequeueReusableCell(withReuseIdentifier:
            DoodleCell.reuseIdentifier, for: indexPath) as! DoodleCell
        doodleCell.setPhoto()
        return doodleCell
    }
    
    func setupPhotos() {
        doodleImageManager.decodeDoodleImagesJSONData()
        doodleImageManager.downloadImages()
    }
    
}
