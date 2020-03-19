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
        print("doodleImageInfos?.count: \(String(describing: doodleImageInfos.count))")
        return doodleImageInfos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let doodleCell = collectionView.dequeueReusableCell(withReuseIdentifier:
            DoodleCell.reuseIdentifier, for: indexPath) as! DoodleCell
        if doodleImages.count != 0 , indexPath.item < doodleImages.count {
            doodleCell.setPhoto(image: doodleImages[indexPath.item])
        }
        return doodleCell
    }
    
    func setupPhotos(resultHandler: @escaping () -> ()) {
        decodeDoodleImagesJSONData { doodleImageInfos in
            var count = 0
            doodleImageInfos?.forEach({
                self.doodleImageManager.downloadImage(urlString: $0.imageURLString) { image in
                    if let image = image {
                        self.doodleImages.append(image)
                    }
                    count += 1
                    if count == 40 {
                        resultHandler()
                        print(count)
                    } else if count == self.doodleImageInfos.count {
                        resultHandler()
                        print(count)
                    }
                }
            })
        }
    }
    
    private func decodeDoodleImagesJSONData(resultHandler: @escaping ([DoodleImageInfo]?) -> ()) {
        DataDecoder.decodeJSONData(from: URLInfo.addressAboutDoodleDatas,
                                   type: [DoodleImageInfo].self,
                                   dateDecodingStrategy: .formatted(DateFormatter.yyyyMMdd)) { doodleImageInfos in
                                    if let doodleImageInfos = doodleImageInfos {
                                        self.doodleImageInfos = doodleImageInfos
                                        resultHandler(doodleImageInfos)
                                    }
        }
    }
    
}
