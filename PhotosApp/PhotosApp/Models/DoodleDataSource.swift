//
//  DoodleDataSource.swift
//  PhotosApp
//
//  Created by jinie on 2020/03/19.
//  Copyright © 2020 jinie. All rights reserved.
//

import UIKit

class DoodleDataSource: NSObject, UICollectionViewDataSource {

    private var doodleImages = [UIImage]()
    private var doodleImageInfos = [DoodleImageInfo]()
    private let doodleImageManager = DoodleImageManager()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return doodleImageInfos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let doodleCell = collectionView.dequeueReusableCell(withReuseIdentifier:
            DoodleCell.reuseIdentifier, for: indexPath) as! DoodleCell
        if doodleImages.count != 0 ,
            indexPath.item < doodleImages.count {
            doodleCell.setPhoto(image: doodleImages[indexPath.item])
        }
        return doodleCell
    }
    
    func setupPhotos(reloadData: @escaping () -> ()) {
        let numberOfItems = 40
        decodeDoodleImagesJSONData { doodleImageInfos in
            var doodleCount = 0
            doodleImageInfos?.forEach({
                self.doodleImageManager.downloadImage(urlString: $0.imageURLString) { image in
                    guard let image = image else {
                        return
                    }
                    self.doodleImages.append(image)
                    doodleCount += 1
                    
                    guard doodleCount == numberOfItems ||
                        self.doodleImages.count == self.doodleImageInfos.count
                        else {
                            return
                    }
                    reloadData()
                }
            })
        }
    }
    
    private func decodeDoodleImagesJSONData(resultHandler: @escaping ([DoodleImageInfo]?) -> ()) {
        DataDecoder.decodeJSONData(from: URLInfo.addressAboutDoodleDatas,
                                   type: [DoodleImageInfo].self,
                                   dateDecodingStrategy: .formatted(DateFormatter.yyyyMMdd)) { doodleImageInfos in
                                    guard let doodleImageInfos = doodleImageInfos
                                        else {
                                            return
                                    }
                                    self.doodleImageInfos = doodleImageInfos
                                    resultHandler(doodleImageInfos)
        }
    }
    
}
