//
//  CollectionViewDataSource.swift
//  PhotosApp
//
//  Created by jinie on 2020/03/16.
//  Copyright © 2020 jinie. All rights reserved.
//

import UIKit

extension CGFloat {
    
    static func randomNumber() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
    
}

extension UIColor {
    
    static func generateRandomColor() -> UIColor {
        return UIColor(red:   .randomNumber(),
                       green: .randomNumber(),
                       blue:  .randomNumber(),
                       alpha: 1.0)
    }
    
}

class PhotosDataSource: NSObject, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let numberOfItems = 40
        return numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reuseIdentifier = "photosCell"
        let cell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        cell.backgroundColor = .generateRandomColor()
        return cell
    }
    
}
