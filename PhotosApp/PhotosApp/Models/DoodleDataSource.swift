//
//  DoodleDataSource.swift
//  PhotosApp
//
//  Created by jinie on 2020/03/19.
//  Copyright © 2020 jinie. All rights reserved.
//

import UIKit
import Photos

final class DoodleDataSource: NSObject, UICollectionViewDataSource {
    
    static let addressAboutDoodleDatas = "https://public.codesquad.kr/jk/doodle.json"
    static let notifiactionDoodleImageInfosDidChange = Notification.Name("doodleImageInfosDidChange")
    
    private var doodleImages = [UIImage]()
    private let doodleImageManager = DoodleImageManager()
    private var doodleImageInfos = [DoodleImageInfo]()
    var collectionView: UICollectionView!
    
    override init() {
        super.init()
        decodeDoodleImagesJSONData()
    }
    
    func decodeDoodleImagesJSONData() {
        DataDecoder.decodeJSONData(from: DoodleDataSource.addressAboutDoodleDatas,
                                   type: [DoodleImageInfo].self,
                                   dateDecodingStrategy:
        .formatted(DateFormatter.yyyyMMdd)) { doodleImageInfos in
            guard let doodleImageInfos = doodleImageInfos else { return }
            self.doodleImageInfos = doodleImageInfos
            NotificationCenter.default.post(name: Self.notifiactionDoodleImageInfosDidChange,
                                            object: self)
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
        let doodleCell = collectionView.dequeueReusableCell(withReuseIdentifier: DoodleCell.reuseIdentifier,
                                                            for: indexPath) as! DoodleCell
        let itemCount = indexPath.item
        if itemCount < doodleImages.count {
            doodleCell.setPhoto(image: doodleImages[itemCount])
        } else {
            requestImage(at: indexPath) { image in
                doodleCell.setPhoto(image: image)
            }
        }
        return doodleCell
    }
    
    private func requestImage(at indexPath: IndexPath, completionHandler: @escaping (UIImage?) -> ()) {
        doodleImageManager.downloadImage(urlString:
        doodleImageInfos[indexPath.item].imageURLString) { image in
            guard let image = image else { return }
            self.doodleImages.append(image)
            completionHandler(image)
        }
    }
    
}
