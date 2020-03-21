//
//  DoodleDataSource.swift
//  PhotosApp
//
//  Created by jinie on 2020/03/19.
//  Copyright © 2020 jinie. All rights reserved.
//

import UIKit
import Photos

class DoodleDataSource: NSObject, UICollectionViewDataSource {
    
    static let notifiactionDoodleImageInfosDidChange = Notification.Name("doodleImageInfosDidChange")
    
    private var doodleImages = [UIImage]()
    private var doodleImageInfos = [DoodleImageInfo]() {
        didSet {
            NotificationCenter.default.post(name: DoodleDataSource.notifiactionDoodleImageInfosDidChange,
                                            object: self)
        }
    }
    private let doodleImageManager = DoodleImageManager()
    
    override init() {
        super.init()
        decodeDoodleImagesJSONData()
    }
    
    func decodeDoodleImagesJSONData() {
        DataDecoder.decodeJSONData(from: URLInfo.addressAboutDoodleDatas,
                                   type: [DoodleImageInfo].self,
                                   dateDecodingStrategy:
                                   .formatted(DateFormatter.yyyyMMdd)) { doodleImageInfos in
                                    guard let doodleImageInfos = doodleImageInfos
                                        else {
                                            return
                                    }
                                    self.doodleImageInfos = doodleImageInfos
        }
    }
    
    func saveImage(indexPath: IndexPath) {
        PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.creationRequestForAsset(from: self.doodleImages[indexPath.item])
        }, completionHandler: nil)
    }
}

extension DoodleDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return doodleImageInfos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let doodleCell = collectionView.dequeueReusableCell(withReuseIdentifier:
            DoodleCell.reuseIdentifier, for: indexPath) as! DoodleCell
        let itemCount = indexPath.item
        guard itemCount < doodleImages.count
            else {
                doodleImageManager.downloadImage(urlString:
                doodleImageInfos[itemCount].imageURLString) { image in
                    guard let image = image else {
                        return
                    }
                    self.doodleImages.append(image)
                    DispatchQueue.main.async {
                        doodleCell.setPhoto(image: image)
                    }
                }
                return doodleCell
        }
        doodleCell.setPhoto(image: doodleImages[itemCount])
        return doodleCell
    }
    
}
